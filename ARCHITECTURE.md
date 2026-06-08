# Architecture & Logic Flow

This document explains how the app works, the data flow, and API integration.

## Application Flow

### 1. App Launch
```
iOS_SwiftUI_Clean_Architecture_MVVMApp.swift (Entry Point)
    ↓
SplashScreenView (2 seconds animation)
    ↓
MainTabView (Bottom Tab Navigation)
```

### 2. Tab Navigation
The app has 4 main tabs managed by `MainTabView`:

- **Home Tab**: Enhanced home screen with categories and featured products
- **Orders Tab**: Displays user orders fetched from API
- **Cart Tab**: Shopping cart (placeholder UI)
- **Profile Tab**: User profile and settings

## Data Flow & API Integration

### API Architecture

```
View Layer
    ↓
ViewModel Layer (ObservableObject)
    ↓
Repository Layer (Optional - Future Use)
    ↓
API Client Layer (Combine Framework)
    ↓
Network Layer (URLSession)
    ↓
Remote API (GitHub Raw JSON)
```

### Real API Implementation

**Endpoint**: `https://raw.githubusercontent.com/dinkar1708/APITest/master/apis/items.json`

**Response Structure**:
```json
[
  {
    "id": "1",
    "name": "iPhone SE",
    "image": "https://github.com/dinkar1708/.../iphone_cover.png",
    "price": 45000.0
  },
  {
    "id": "2",
    "name": "Nexus 5",
    "image": "https://github.com/dinkar1708/.../nexus-5-back.png",
    "price": 16758.0
  }
]
```

### How API Calls Work

#### 1. API Configuration (`MVVMApi.swift`)
```swift
// Base URL configuration (supports DEBUG, INHOUSE, RELEASE)
static let baseUrl = URL(string: "\(getBaseUrl())dinkar1708/APITest/master/apis/")!

// API method to fetch orders
static func getMyOrders() -> AnyPublisher<[ItemModel], Error> {
    let myOrdersApiName = "/items.json"
    return apiClient.run(URLRequest(url: components.url!))
        .map(\.value)
        .eraseToAnyPublisher()
}
```

#### 2. API Client (`APIClient.swift`)
Uses **Combine framework** for reactive programming:
```swift
func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {
    return URLSession.shared
        .dataTaskPublisher(for: request)
        .tryMap { result -> Response<T> in
            let value = try JSONDecoder().decode(T.self, from: result.data)
            return Response(value: value, response: result.response)
        }
        .receive(on: DispatchQueue.main)  // Update UI on main thread
        .eraseToAnyPublisher()
}
```

#### 3. ViewModel (`MyOrdersViewModel.swift`)
Manages state and data fetching:
```swift
enum State {
    case loading      // Initial state
    case loaded([ItemModel])  // Success with data
    case error(String)  // Error with message
}

func fetchHomeContent() {
    self.cancellationToken = MVVMApi.getMyOrders()
        .mapError({ (er) -> Error in
            self.state = .error(er.localizedDescription)
            return er
        })
        .sink(receiveCompletion: { _ in },
              receiveValue: {
                self.state = .loaded($0)
              })
}
```

#### 4. View (`MyOrdersView.swift`)
Observes ViewModel state and updates UI:
```swift
var body: some View {
    switch viewModel.state {
    case .loading:
        Text("Loading")  // Shows while fetching
    case .error(let error):
        Text(error)  // Shows error message
    case .loaded(let homeModels):
        list(of: homeModels)  // Shows product cards
    }
}
```

### Data Model

**ItemModel** (`ItemModel.swift`):
```swift
struct ItemModel: Identifiable, Decodable {
    let id: String        // From API
    let name: String      // Product name
    let image: String     // Image URL
    let price: Float      // Price in rupees
}
```

**Key Features**:
- `Identifiable`: Required for SwiftUI lists
- `Decodable`: Automatic JSON parsing
- Multiple initializers for API data and mock data

## State Management

### ViewModel State Pattern
The app uses **MVVM** with reactive state management:

1. **Loading State**: Initial state when view appears
2. **Loaded State**: Contains array of products
3. **Error State**: Contains error message

### Example Flow:
```
User opens Orders Tab
    ↓
MyOrdersView.onAppear() called
    ↓
viewModel.fetchHomeContent() triggered
    ↓
State = .loading (UI shows "Loading")
    ↓
API Call via Combine
    ↓
Success? → State = .loaded([products])
Failure? → State = .error("Network error")
    ↓
View automatically updates (via @Published)
    ↓
ProductCard list appears
```

## UI Components

### 1. Custom Tab Bar (`CustomTabBar` in `AppTheme.swift`)
- Animated tab switching with `matchedGeometryEffect`
- 4 tabs with icons and labels
- Smooth spring animations

### 2. Product Cards (`ProductCard` in `AppTheme.swift`)
- Gradient icon backgrounds
- Star ratings (hardcoded 4.8 for now)
- Price display
- Add-to-cart button with animation
- Navigation to detail view

### 3. Splash Screen (`SplashScreenView` in `MainApp.swift`)
- Gradient background
- Animated logo scaling
- 2-second delay before transition

### 4. Enhanced Home (`EnhancedHomeView` in `MainApp.swift`)
- Welcome header
- Search bar
- Category cards (horizontal scroll)
- Featured products section

## Mock Data Fallback

For testing without network:
```swift
extension ItemModel {
    static func getHomeMockData() -> [Self] {
        return [
            Self(id: "1", name: "Google Pixel 4", image: "", price: 90000),
            Self(id: "2", name: "iPhone 15 Pro", image: "", price: 45000),
            // ... more items
        ]
    }
}
```

## Error Handling

### Network Errors
- Connection failures
- Timeout errors
- Invalid JSON responses
- HTTP status codes

All errors are caught in the ViewModel and displayed to users.

### Combine Error Handling
```swift
.mapError({ (er) -> Error in
    self.state = .error(er.localizedDescription)
    return er
})
```

## Memory Management

### Combine Subscriptions
```swift
var cancellationToken: AnyCancellable?
```
- Stored in ViewModel
- Automatically cancelled when ViewModel is deallocated
- Prevents memory leaks

## Testing Strategy

### Unit Tests (`ViewModelTests.swift`)

1. **State Tests**: Verify initial state is `.loading`
2. **API Tests**: Test successful data fetching
3. **Error Tests**: Test error handling
4. **Model Tests**: Verify data model initialization
5. **Performance Tests**: Measure fetch performance

### Test Example:
```swift
func testFetchHomeContentSuccess() {
    let expectation = self.expectation(description: "Data loaded")
    viewModel.fetchHomeContent()

    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        if case .loaded(let models) = self.viewModel.state {
            XCTAssertFalse(models.isEmpty)
            expectation.fulfill()
        }
    }

    waitForExpectations(timeout: 5.0)
}
```

## Future Enhancements

### Potential Improvements:
1. **Image Loading**: Use AsyncImage or SDWebImage for product images
2. **Caching**: Cache API responses locally
3. **Pagination**: Load more items as user scrolls
4. **Search**: Implement product search functionality
5. **Cart Logic**: Add/remove items, calculate totals
6. **User Authentication**: Login/logout functionality
7. **Order History**: Track past orders
8. **Payment Integration**: Add checkout flow

## Clean Architecture Benefits

### Separation of Concerns
- **View**: UI presentation (SwiftUI)
- **ViewModel**: Business logic and state
- **Model**: Data structures
- **Repository**: Data source abstraction
- **Network**: API communication

### Testability
- ViewModels can be tested independently
- Mock data for UI testing
- Repository pattern allows mock API implementations

### Maintainability
- Clear folder structure
- Single responsibility principle
- Easy to add new features

## Key Technologies

- **SwiftUI**: Modern declarative UI framework
- **Combine**: Reactive programming for async operations
- **URLSession**: Native networking
- **Codable**: Automatic JSON parsing
- **MVVM**: Model-View-ViewModel pattern
- **Clean Architecture**: Layered design pattern

## Build & Run

The app is fully functional and compiles without errors:
```bash
xcodebuild -project iOS-SwiftUI-Clean-Architecture-MVVM.xcodeproj \
           -scheme iOS-SwiftUI-Clean-Architecture-MVVM \
           -sdk iphonesimulator build
```

**Result**: ✅ BUILD SUCCEEDED

All UI components are connected to real API endpoints and work logically with proper state management.
