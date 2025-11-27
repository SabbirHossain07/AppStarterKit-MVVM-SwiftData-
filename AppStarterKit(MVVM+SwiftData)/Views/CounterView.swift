//
//  CounterView.swift
//  AppStarterKit(MVVM+SwiftData)
//
//  Created by Sopnil Sohan on 27/11/25.
//

import SwiftUI
import SwiftData

struct CounterView: View {
    @StateObject private var viewModel: CounterViewModel
    @AppStorage("counterTheme") private var counterTheme: String = "default"
    
    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: CounterViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Title
            Text(viewModel.counter?.title ?? "Counter")
                .appTypography(AppTypography.headlineLarge)
                .foregroundColor(AppColors.defaultTextPrimary)
            
            // Counter Value
            Text("\(viewModel.counter?.value ?? 0)")
                .appTypography(AppTypography.displayMedium)
                .foregroundColor(AppColors.defaultPrimary)
                .padding(AppSpacing.xl)
                .frame(maxWidth: .infinity)
                .background(AppColors.defaultSurface)
                .cornerRadius(AppSpacing.md)
            
            // Error Message
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .appTypography(AppTypography.bodySmall)
                    .foregroundColor(AppColors.defaultError)
                    .padding(AppSpacing.sm)
            }
            
            // Control Buttons
            HStack(spacing: AppSpacing.md) {
                Button(action: { viewModel.decrement() }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(AppColors.defaultError)
                }
                
                Button(action: { viewModel.reset() }) {
                    Text("Reset")
                        .appTypography(AppTypography.labelLarge)
                        .foregroundColor(.white)
                        .padding(.horizontal, AppSpacing.md)
                        .padding(.vertical, AppSpacing.sm)
                        .background(AppColors.defaultWarning)
                        .cornerRadius(AppSpacing.sm)
                }
                
                Button(action: { viewModel.increment() }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(AppColors.defaultSuccess)
                }
            }
            .padding(.top, AppSpacing.md)
            
            // AppStorage Example
            VStack(spacing: AppSpacing.sm) {
                Text("Theme Setting (AppStorage Example)")
                    .appTypography(AppTypography.titleSmall)
                    .foregroundColor(AppColors.defaultTextSecondary)
                
                Picker("Theme", selection: $counterTheme) {
                    Text("Default").tag("default")
                    Text("Dark").tag("dark")
                    Text("Light").tag("light")
                }
                .pickerStyle(.segmented)
            }
            .padding(.top, AppSpacing.lg)
            
            Spacer()
        }
        .padding(AppSpacing.screenPadding)
        .background(AppColors.defaultBackground)
    }
}

// MARK: - Preview
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Counter.self, configurations: config)
    let context = container.mainContext
    
    // Add sample data
    let sampleCounter = Counter(value: 42, title: "Preview Counter")
    context.insert(sampleCounter)
    
    return CounterView(modelContext: context)
        .modelContainer(container)
}

