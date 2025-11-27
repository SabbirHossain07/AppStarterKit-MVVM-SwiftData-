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
    @Environment(\.colorScheme) private var systemColorScheme
    
    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: CounterViewModel(modelContext: modelContext))
    }
    
    // Computed property to get the effective color scheme
    private var effectiveColorScheme: ColorScheme? {
        switch counterTheme {
        case "dark":
            return .dark
        case "light":
            return .light
        default:
            return nil // Use system default
        }
    }
    
    // Theme-aware colors
    private var backgroundColor: Color {
        switch counterTheme {
        case "dark":
            return Color.black
        case "light":
            return Color.white
        default:
            return AppColors.defaultBackground
        }
    }
    
    private var textPrimaryColor: Color {
        switch counterTheme {
        case "dark":
            return Color.white
        case "light":
            return Color.black
        default:
            return AppColors.defaultTextPrimary
        }
    }
    
    private var textSecondaryColor: Color {
        switch counterTheme {
        case "dark":
            return Color.gray.opacity(0.8)
        case "light":
            return Color.gray
        default:
            return AppColors.defaultTextSecondary
        }
    }
    
    private var surfaceColor: Color {
        switch counterTheme {
        case "dark":
            return Color.gray.opacity(0.2)
        case "light":
            return Color.gray.opacity(0.1)
        default:
            return AppColors.defaultSurface
        }
    }
    
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Title
            Text(viewModel.counter?.title ?? "Counter")
                .appTypography(AppTypography.headlineLarge)
                .foregroundColor(textPrimaryColor)
            
            // Counter Value
            Text("\(viewModel.counter?.value ?? 0)")
                .appTypography(AppTypography.displayMedium)
                .foregroundColor(AppColors.defaultPrimary)
                .padding(AppSpacing.xl)
                .frame(maxWidth: .infinity)
                .background(surfaceColor)
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
            
            // AppStorage Example - Theme Picker
            VStack(spacing: AppSpacing.sm) {
                Text("Theme Setting (AppStorage Example)")
                    .appTypography(AppTypography.titleSmall)
                    .foregroundColor(textSecondaryColor)
                
                Picker("Theme", selection: $counterTheme) {
                    Text("Default").tag("default")
                    Text("Dark").tag("dark")
                    Text("Light").tag("light")
                }
                .pickerStyle(.segmented)
                .onChange(of: counterTheme) { oldValue, newValue in
                    // Theme change is automatically applied via computed properties
                    // AppStorage persists the selection automatically
                }
            }
            .padding(.top, AppSpacing.lg)
            
            Spacer()
        }
        .padding(AppSpacing.screenPadding)
        .background(backgroundColor)
        .preferredColorScheme(effectiveColorScheme)
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

