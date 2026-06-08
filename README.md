# iOS-SwiftUI-Clean-Architecture-MVVM

A modern iOS shopping app built with SwiftUI following Clean Architecture and MVVM design patterns. Features a beautiful UI with custom tab bar, animated splash screen, and modern color scheme.

## User Testing Flows

[View All Testing Flows](docs/user-flows/) - 6 practical user flows for manual testing

Test the complete app experience:
- [Flow 01 - First Launch and Browse](docs/user-flows/01-first-launch-and-browse.md)
- [Flow 02 - Shopping and Cart Management](docs/user-flows/02-shopping-and-cart-management.md)
- [Flow 03 - Complete Purchase Flow](docs/user-flows/03-complete-purchase-flow.md)
- [Flow 04 - Order History](docs/user-flows/04-order-history.md)
- [Flow 05 - Profile and Settings](docs/user-flows/05-profile-and-settings.md)
- [Flow 06 - Navigation and Edge Cases](docs/user-flows/06-navigation-and-edge-cases.md)

## Features

### Shopping Experience
- Complete shopping flow from browsing to order placement
- Interactive product catalog with add-to-cart functionality
- Shopping cart with quantity management
- Full-screen checkout with order review
- Order history tracking
- Toast notifications and smooth animations

### Architecture
- Clean Architecture: Separation of concerns with distinct layers
- MVVM Pattern: Model-View-ViewModel for better testability
- State Management: CartManager singleton for global state
- SwiftUI: Modern declarative UI framework

For detailed feature documentation, see [User Testing Flows](docs/user-flows/)

### Screenshots
![Simulator Screenshot - iPhone 15 Pro Max - 2024-03-09 at 18 49 51](https://github.com/dinkar1708/iOS-SwiftUI-Clean-Architecture-MVVM/assets/14831652/cce51b17-1bc8-44af-b98d-1d6fc88984b2)
![Simulator Screenshot - iPhone 15 Pro Max - 2024-03-09 at 18 49 53](https://github.com/dinkar1708/iOS-SwiftUI-Clean-Architecture-MVVM/assets/14831652/cc43cc6f-0907-4553-b788-e7c9f06d0418)

## Requirements

- Xcode 14.0+
- iOS 14.0+
- Swift 5.0+
- macOS 12.0+ (for development)

## Project Structure

```
iOS-SwiftUI-Clean-Architecture-MVVM/
├── iOS-SwiftUI-Clean-Architecture-MVVM/
│   ├── app/
│   │   ├── Common/
│   │   │   ├── AppTheme.swift          # Colors, TabBar, ProductCard
│   │   │   ├── CartManager.swift       # State management
│   │   │   └── MenuCellView.swift      # Menu components
│   │   ├── UI/
│   │   │   ├── MainApp.swift           # Splash, TabView, Cart, Checkout
│   │   │   └── features/
│   │   │       ├── Home/               # Home view
│   │   │       ├── MyOrders/           # Orders view & ViewModel
│   │   │       └── OrderDetails/       # Order details
│   │   └── data/
│   │       ├── Repository/             # Data repositories
│   │       └── Source/Network/         # API client & models
│   └── iOS_SwiftUI_Clean_Architecture_MVVMApp.swift
├── iOS-SwiftUI-Clean-Architecture-MVVMTests/
│   └── ViewModelTests.swift            # Unit tests
└── docs/
    └── user-flows/                     # 6 manual testing flows
        ├── 01-first-launch-and-browse.md
        ├── 02-shopping-and-cart-management.md
        ├── 03-complete-purchase-flow.md
        ├── 04-order-history.md
        ├── 05-profile-and-settings.md
        └── 06-navigation-and-edge-cases.md
```

## Building and Running the Project

### Using Xcode (Recommended)

1. Clone the repository
   ```bash
   git clone https://github.com/dinkar1708/iOS-SwiftUI-Clean-Architecture-MVVM.git
   cd iOS-SwiftUI-Clean-Architecture-MVVM
   ```

2. Open the project in Xcode
   ```bash
   open iOS-SwiftUI-Clean-Architecture-MVVM.xcodeproj
   ```

3. Select a simulator
   - Choose any iPhone simulator from the device menu (e.g., iPhone 15, iPhone 14 Pro)

4. Build and Run
   - Press Cmd + R or click the Play button
   - The app will launch with an animated splash screen

### Using Terminal

1. Build the project
   ```bash
   xcodebuild -project iOS-SwiftUI-Clean-Architecture-MVVM.xcodeproj \
              -scheme iOS-SwiftUI-Clean-Architecture-MVVM \
              -sdk iphonesimulator \
              -destination 'platform=iOS Simulator,name=iPhone 15' \
              build
   ```

2. Run the project
   ```bash
   # Build and run in simulator
   xcodebuild -project iOS-SwiftUI-Clean-Architecture-MVVM.xcodeproj \
              -scheme iOS-SwiftUI-Clean-Architecture-MVVM \
              -sdk iphonesimulator \
              -destination 'platform=iOS Simulator,name=iPhone 15' \
              build

   # The simulator should launch automatically
   # If not, you can open Simulator.app and install the built app
   ```

3. Clean build (if needed)
   ```bash
   xcodebuild -project iOS-SwiftUI-Clean-Architecture-MVVM.xcodeproj \
              -scheme iOS-SwiftUI-Clean-Architecture-MVVM \
              -sdk iphonesimulator \
              clean
   ```

## Running Tests

### User Testing Flows

This project includes 6 practical user flows in the docs/user-flows/ folder for manual testing. Each flow represents a complete user journey:

1. First Launch and Browse - Initial app experience
2. Shopping and Cart Management - Adding and managing items
3. Complete Purchase Flow - Full checkout process
4. Order History - Viewing past orders
5. Profile and Settings - User profile management
6. Navigation and Edge Cases - Tab navigation and error states

Each flow includes:
- What to test
- Step-by-step instructions
- Expected results and behaviors

These flows help manual testers verify all features work correctly in real-world usage scenarios.

### Best Practices for Testing

This project follows iOS testing best practices:

1. User Flow Based: Tests based on real-world usage scenarios
2. Unit Tests: Test individual components in isolation
3. Manual Testing: Use documented flows to verify features
4. Given-When-Then: Clear test structure for readability
5. Mock Data: Use mock data for predictable testing

### Test Coverage

Current unit tests include:
- ViewModel state management tests
- Model creation and validation tests
- Repository data fetching tests
- Color theme initialization tests

For manual testing, refer to the [user flows](docs/user-flows/) documentation.

### Running Tests via Xcode

1. Open the project in Xcode
2. Press `Cmd + U` to run all tests
3. Or navigate to `Product > Test` from the menu
4. View results in the Test Navigator (Cmd + 6)

### Running Tests via Terminal

```bash
# Run all tests
xcodebuild test \
  -project iOS-SwiftUI-Clean-Architecture-MVVM.xcodeproj \
  -scheme iOS-SwiftUI-Clean-Architecture-MVVM \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 15'

# Run specific test class
xcodebuild test \
  -project iOS-SwiftUI-Clean-Architecture-MVVM.xcodeproj \
  -scheme iOS-SwiftUI-Clean-Architecture-MVVM \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 15' \
  -only-testing:iOS-SwiftUI-Clean-Architecture-MVVMTests/MyOrdersViewModelTests

# Run with test coverage
xcodebuild test \
  -project iOS-SwiftUI-Clean-Architecture-MVVM.xcodeproj \
  -scheme iOS-SwiftUI-Clean-Architecture-MVVM \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 15' \
  -enableCodeCoverage YES
```

### Viewing Test Results

```bash
# Format test output for better readability (install xcpretty first)
brew install xcpretty

xcodebuild test \
  -project iOS-SwiftUI-Clean-Architecture-MVVM.xcodeproj \
  -scheme iOS-SwiftUI-Clean-Architecture-MVVM \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 15' | xcpretty
```

## Code Style

- Swift Style Guide: Follows standard Swift conventions
- SwiftUI Best Practices: Uses native SwiftUI components
- Clean Code: Readable, maintainable, and well-documented
- Separation of Concerns: Clear boundaries between layers

## Color Scheme

The app uses a modern, vibrant color palette:

- Primary: #6C5CE7 (Vibrant Purple)
- Secondary: #00B894 (Fresh Mint Green)
- Accent: #FD79A8 (Soft Pink)
- Background: #F8F9FA (Light Gray)
- Text Primary: #2D3436 (Dark Gray)
- Text Secondary: #636E72 (Medium Gray)

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is available for educational and personal use.

## Author

Dinakar Maurya

## Acknowledgments

- Built with SwiftUI
- Follows Clean Architecture principles
- Implements MVVM design pattern


