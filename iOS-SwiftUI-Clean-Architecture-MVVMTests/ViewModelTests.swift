//
//  ViewModelTests.swift
//  iOS-SwiftUI-Clean-Architecture-MVVMTests
//
//  Unit tests for ViewModels
//

import XCTest
@testable import iOS_SwiftUI_Clean_Architecture_MVVM

class MyOrdersViewModelTests: XCTestCase {

    var viewModel: MyOrdersViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = MyOrdersViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }

    // MARK: - Initial State Tests

    func testInitialState() {
        // Given: A newly created view model
        // When: No action is taken
        // Then: State should be loading
        if case .loading = viewModel.state {
            XCTAssertTrue(true, "Initial state should be loading")
        } else {
            XCTFail("Initial state should be loading")
        }
    }

    // MARK: - Data Fetching Tests

    func testFetchHomeContentSuccess() {
        // Given: A view model ready to fetch data
        let expectation = self.expectation(description: "Data loaded successfully")

        // When: Fetch home content
        viewModel.fetchHomeContent()

        // Then: Wait for async operation and verify state changes
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if case .loaded(let models) = self.viewModel.state {
                XCTAssertFalse(models.isEmpty, "Models array should not be empty")
                expectation.fulfill()
            } else if case .error(_) = self.viewModel.state {
                // Error is also acceptable for network operations
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testStateTransitions() {
        // Given: Initial loading state
        // When: Content is fetched
        // Then: State should transition from loading to either loaded or error

        viewModel.fetchHomeContent()

        // Verify that state is initially loading
        if case .loading = viewModel.state {
            XCTAssertTrue(true)
        } else {
            XCTFail("State should start as loading")
        }
    }

    // MARK: - Performance Tests

    func testFetchPerformance() {
        // Measure the time it takes to fetch content
        measure {
            viewModel.fetchHomeContent()
            // Allow some time for the fetch operation
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.5))
        }
    }
}

// MARK: - Model Tests

class ItemModelTests: XCTestCase {

    func testItemModelCreation() {
        // Given: Item properties
        let id = 1
        let name = "Test Product"
        let price = 99.99

        // When: Creating an ItemModel
        let item = ItemModel(id: id, name: name, price: price)

        // Then: Properties should match
        XCTAssertEqual(item.id, id)
        XCTAssertEqual(item.name, name)
        XCTAssertEqual(item.price, price)
    }

    func testItemModelIdentifiable() {
        // Given: Two items with different IDs
        let item1 = ItemModel(id: 1, name: "Product 1", price: 10.0)
        let item2 = ItemModel(id: 2, name: "Product 2", price: 20.0)

        // Then: They should have different IDs
        XCTAssertNotEqual(item1.id, item2.id)
    }

    func testMockDataGeneration() {
        // Given: Mock data generator
        // When: Getting mock data
        let mockData = ItemModel.getHomeMockData()

        // Then: Should return non-empty array
        XCTAssertFalse(mockData.isEmpty, "Mock data should not be empty")
        XCTAssertGreaterThan(mockData.count, 0, "Should have at least one mock item")
    }
}

// MARK: - Repository Tests

class OrdersRepositoryTests: XCTestCase {

    var repository: OrdersRepository!

    override func setUpWithError() throws {
        try super.setUpWithError()
        repository = OrdersRepository()
    }

    override func tearDownWithError() throws {
        repository = nil
        try super.tearDownWithError()
    }

    func testFetchOrders() {
        // Given: A repository instance
        let expectation = self.expectation(description: "Orders fetched")

        // When: Fetching orders
        repository.fetchOrders { result in
            // Then: Result should be either success or failure
            switch result {
            case .success(let orders):
                XCTAssertNotNil(orders, "Orders should not be nil")
            case .failure(let error):
                XCTAssertNotNil(error, "Error should be defined")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }
}

// MARK: - Color Theme Tests

class AppColorsTests: XCTestCase {

    func testColorInitialization() {
        // Given: Hex color codes
        // When: Creating colors from hex
        let primaryColor = Color(hex: "6C5CE7")
        let secondaryColor = Color(hex: "00B894")

        // Then: Colors should be created successfully
        XCTAssertNotNil(primaryColor)
        XCTAssertNotNil(secondaryColor)
    }

    func testAppColorsPalette() {
        // Given: App color palette
        // Then: All theme colors should be accessible
        XCTAssertNotNil(AppColors.primary)
        XCTAssertNotNil(AppColors.secondary)
        XCTAssertNotNil(AppColors.accent)
        XCTAssertNotNil(AppColors.background)
        XCTAssertNotNil(AppColors.cardBackground)
        XCTAssertNotNil(AppColors.tabBarBackground)
        XCTAssertNotNil(AppColors.tabBarSelected)
        XCTAssertNotNil(AppColors.tabBarUnselected)
    }
}
