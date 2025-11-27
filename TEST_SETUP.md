# Test Target Setup Guide

## The Problem
The test files were showing "No such module 'XCTest'" because they need to be in a separate **Test Target**, not the main app target.

## Solution: Create a Test Target in Xcode

### Step 1: Create the Test Target
1. In Xcode, select your project in the Project Navigator (top item)
2. Click the **+** button at the bottom of the TARGETS list
3. Select **Unit Testing Bundle**
4. Click **Next**
5. Name it: `AppStarterKit(MVVM+SwiftData)Tests`
6. Make sure "Target to be Tested" is set to `AppStarterKit(MVVM+SwiftData)`
7. Click **Finish**

### Step 2: Add Test Files to the Target
1. Select all test files in `AppStarterKit(MVVM+SwiftData)Tests/` folder:
   - `CounterModelTests.swift`
   - `CounterViewModelTests.swift`
   - `APIServiceTests.swift`
2. In the File Inspector (right panel), under **Target Membership**, check the box for `AppStarterKit(MVVM+SwiftData)Tests`
3. **Uncheck** the box for `AppStarterKit(MVVM+SwiftData)` (the main app target)

### Step 3: Configure Test Target Settings
1. Select the test target `AppStarterKit(MVVM+SwiftData)Tests`
2. Go to **Build Settings**
3. Search for "Swift Compiler - General"
4. Under **Import Paths**, make sure the main app's source files are accessible
5. Go to **Build Phases** → **Compile Sources**
6. Verify all test files are listed there

### Step 4: Verify XCTest Framework
1. In the test target's **Build Phases** → **Link Binary With Libraries**
2. Make sure `XCTest.framework` is listed (it should be automatically added)

### Step 5: Run Tests
- Press **Cmd + U** to run all tests
- Or use the Test Navigator (Cmd + 6) to run individual tests

## Alternative: Quick Fix via Xcode UI

If the above seems complex, you can also:

1. **Right-click** on the `AppStarterKit(MVVM+SwiftData)Tests` folder in Xcode
2. Select **New File...**
3. Choose **Unit Test Case Class**
4. Name it (e.g., `CounterModelTests`)
5. Xcode will automatically create the test target if it doesn't exist
6. Then copy the test code from the existing files

## Verify It Works

After setup, the test files should:
- ✅ Import XCTest without errors
- ✅ Show green checkmarks in the Test Navigator
- ✅ Run successfully with Cmd + U

---

**Note:** The test files have been moved to `AppStarterKit(MVVM+SwiftData)Tests/` at the project root level, which is the standard Xcode project structure.

