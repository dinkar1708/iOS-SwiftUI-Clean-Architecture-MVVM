//
//  CartManager.swift
//  iOS-SwiftUI-Clean-Architecture-MVVM
//
//  Shopping cart state management
//

import Foundation
import Combine

// MARK: - Cart Item Model
struct CartItem: Identifiable {
    let id = UUID()
    let product: ItemModel
    var quantity: Int

    var totalPrice: Float {
        return product.price * Float(quantity)
    }
}

// MARK: - Order Model
struct Order: Identifiable {
    let id = UUID()
    let orderNumber: String
    let items: [CartItem]
    let totalAmount: Float
    let date: Date
    let status: String

    var itemCount: Int {
        return items.reduce(0) { $0 + $1.quantity }
    }
}

// MARK: - Cart Manager (Singleton)
class CartManager: ObservableObject {
    static let shared = CartManager()

    @Published var cartItems: [CartItem] = []
    @Published var orders: [Order] = []

    private init() {}

    // MARK: - Cart Operations

    func addToCart(product: ItemModel) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            // Item already in cart, increase quantity
            cartItems[index].quantity += 1
        } else {
            // New item, add to cart
            let cartItem = CartItem(product: product, quantity: 1)
            cartItems.append(cartItem)
        }
    }

    func removeFromCart(cartItem: CartItem) {
        cartItems.removeAll { $0.id == cartItem.id }
    }

    func updateQuantity(cartItem: CartItem, quantity: Int) {
        if let index = cartItems.firstIndex(where: { $0.id == cartItem.id }) {
            if quantity > 0 {
                cartItems[index].quantity = quantity
            } else {
                cartItems.remove(at: index)
            }
        }
    }

    func clearCart() {
        cartItems.removeAll()
    }

    var cartTotal: Float {
        return cartItems.reduce(0) { $0 + $1.totalPrice }
    }

    var itemCount: Int {
        return cartItems.reduce(0) { $0 + $1.quantity }
    }

    // MARK: - Order Operations

    func placeOrder() -> Order {
        let orderNumber = "ORD-\(Int.random(in: 10000...99999))"
        let order = Order(
            orderNumber: orderNumber,
            items: cartItems,
            totalAmount: cartTotal,
            date: Date(),
            status: "Processing"
        )

        orders.insert(order, at: 0) // Add to beginning
        clearCart()

        return order
    }

    func getOrders() -> [Order] {
        return orders
    }
}
