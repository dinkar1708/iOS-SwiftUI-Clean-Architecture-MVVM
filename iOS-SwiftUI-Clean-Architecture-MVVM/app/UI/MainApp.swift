//
//  MainApp.swift
//  iOS-SwiftUI-Clean-Architecture-MVVM
//
//  Main app views - Splash, Tab View, and Screens
//

import SwiftUI

// MARK: - Splash Screen
struct SplashScreenView: View {
    @State private var isActive = false
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0

    var body: some View {
        if isActive {
            MainTabView()
        } else {
            ZStack {
                LinearGradient(colors: [AppColors.primary, AppColors.gradientEnd, AppColors.secondary], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    ZStack {
                        Circle()
                            .stroke(LinearGradient(colors: [Color.white.opacity(0.5), Color.white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 3)
                            .frame(width: 140, height: 140)

                        Image(systemName: "bag.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70, height: 70)
                            .foregroundColor(.white)
                    }
                    .scaleEffect(scale)

                    VStack(spacing: 8) {
                        Text("Market")
                            .font(.system(size: 42, weight: .bold, design: .rounded))
                            .foregroundColor(.white)

                        Text("Your Premium Shopping Experience")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .opacity(opacity)
                }
            }
            .onAppear {
                withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                    scale = 1.0
                }
                withAnimation(.easeIn(duration: 0.6)) {
                    opacity = 1.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        isActive = true
                    }
                }
            }
        }
    }
}

// MARK: - Main Tab View
struct MainTabView: View {
    @State private var selectedTab: TabItem = .home
    @StateObject private var ordersViewModel = MyOrdersViewModel()
    @State private var showToast = false
    @State private var toastMessage = ""

    var body: some View {
        ZStack(alignment: .bottom) {
            AppColors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                tabContent.frame(maxWidth: .infinity, maxHeight: .infinity)
            }

            CustomTabBar(selectedTab: $selectedTab)

            // Toast Notification
            if showToast {
                ToastView(message: toastMessage)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(100)
                    .padding(.bottom, 100)
            }
        }
    }

    @ViewBuilder
    private var tabContent: some View {
        switch selectedTab {
        case .home: EnhancedHomeView()
        case .orders: MyOrdersView(viewModel: ordersViewModel)
        case .cart: CartView(selectedTab: $selectedTab, showToast: $showToast, toastMessage: $toastMessage)
        case .profile: ProfileView()
        }
    }
}

// MARK: - Enhanced Home View
struct EnhancedHomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Welcome Back!")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(AppColors.textSecondary)
                                Text("Explore Best Deals")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(AppColors.textPrimary)
                            }
                            Spacer()
                            Button(action: {}) {
                                ZStack {
                                    Circle()
                                        .fill(AppColors.primary.opacity(0.1))
                                        .frame(width: 48, height: 48)
                                    Image(systemName: "bell.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(AppColors.primary)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)

                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(AppColors.textSecondary)
                            Text("Search products...")
                                .foregroundColor(AppColors.textLight)
                            Spacer()
                        }
                        .padding()
                        .background(AppColors.cardBackground)
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
                        .padding(.horizontal, 20)
                    }

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Categories")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(AppColors.textPrimary)
                            .padding(.horizontal, 20)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                CategoryCard(icon: "bag.fill", title: "Fashion", color: AppColors.primary)
                                CategoryCard(icon: "desktopcomputer", title: "Electronics", color: AppColors.secondary)
                                CategoryCard(icon: "book.fill", title: "Books", color: AppColors.accent)
                                CategoryCard(icon: "sportscourt.fill", title: "Sports", color: AppColors.info)
                            }
                            .padding(.horizontal, 20)
                        }
                    }

                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Featured Products")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(AppColors.textPrimary)
                            Spacer()
                        }
                        .padding(.horizontal, 20)

                        // Show mock products on Home (not API products)
                        LazyVStack(spacing: 16) {
                            ForEach(ItemModel.getHomeMockData()) { product in
                                ProductCard(model: product)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 80)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct CategoryCard: View {
    let icon: String
    let title: String
    let color: Color

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [color, color.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 60, height: 60)
                Image(systemName: icon)
                    .font(.system(size: 26))
                    .foregroundColor(.white)
            }
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(AppColors.textPrimary)
        }
        .padding()
        .background(AppColors.cardBackground)
        .cornerRadius(20)
        .shadow(color: color.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

// MARK: - Cart View
struct CartView: View {
    @ObservedObject var cartManager = CartManager.shared
    @State private var showCheckout = false
    @Binding var selectedTab: TabItem
    @Binding var showToast: Bool
    @Binding var toastMessage: String

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                AppColors.background.ignoresSafeArea()

                if cartManager.cartItems.isEmpty {
                    // Empty Cart State
                    VStack(spacing: 20) {
                        Image(systemName: "cart.fill")
                            .font(.system(size: 60))
                            .foregroundColor(AppColors.primary)
                            .padding()
                        Text("Your Cart is Empty")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(AppColors.textPrimary)
                        Text("Add items to get started")
                            .font(.system(size: 16))
                            .foregroundColor(AppColors.textSecondary)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    // Cart Items with fixed bottom checkout
                    VStack(spacing: 0) {
                        // Scrollable items
                        ScrollView {
                            VStack(spacing: 16) {
                                ForEach(cartManager.cartItems) { item in
                                    CartItemRow(item: item)
                                }
                            }
                            .padding(20)
                            .padding(.bottom, 180)  // Space for bottom section + tab bar
                        }

                        Spacer()
                    }

                    // Fixed Bottom Checkout Section
                    VStack(spacing: 0) {
                        VStack(spacing: 12) {
                            // Total Section
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Total Amount")
                                        .font(.system(size: 14))
                                        .foregroundColor(AppColors.textSecondary)
                                    Text("₹\(String(format: "%.0f", cartManager.cartTotal))")
                                        .font(.system(size: 28, weight: .bold))
                                        .foregroundColor(AppColors.textPrimary)
                                }
                                Spacer()
                                Text("\(cartManager.itemCount) items")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(AppColors.textSecondary)
                            }

                            // Checkout Button
                            Button(action: { showCheckout = true }) {
                                HStack {
                                    Text("Proceed to Checkout")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.white)
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .padding(.horizontal, 20)
                                .background(
                                    LinearGradient(
                                        colors: [AppColors.primary, AppColors.gradientEnd],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(16)
                                .shadow(color: AppColors.primary.opacity(0.4), radius: 12, x: 0, y: 6)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(20)
                        .padding(.bottom, 80)  // Space above tab bar
                        .background(
                            AppColors.cardBackground
                                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
                        )
                    }
                }
            }
            .navigationBarTitle("Cart", displayMode: .large)
            .fullScreenCover(isPresented: $showCheckout) {
                CheckoutView(
                    selectedTab: $selectedTab,
                    showToast: $showToast,
                    toastMessage: $toastMessage,
                    isPresented: $showCheckout
                )
            }
        }
    }
}

// MARK: - Cart Item Row
struct CartItemRow: View {
    let item: CartItem
    @ObservedObject var cartManager = CartManager.shared

    var body: some View {
        HStack(spacing: 16) {
            // Product Image
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(LinearGradient(colors: [AppColors.primary.opacity(0.2), AppColors.secondary.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 70, height: 70)
                Image(systemName: "bag.fill")
                    .font(.system(size: 28))
                    .foregroundColor(AppColors.primary)
            }

            // Product Info
            VStack(alignment: .leading, spacing: 6) {
                Text(item.product.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(AppColors.textPrimary)
                    .lineLimit(2)
                Text("₹\(String(format: "%.0f", item.product.price))")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(AppColors.primary)
            }

            Spacer()

            // Quantity Controls
            VStack(spacing: 8) {
                HStack(spacing: 12) {
                    Button(action: {
                        cartManager.updateQuantity(cartItem: item, quantity: item.quantity - 1)
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(AppColors.textLight)
                    }

                    Text("\(item.quantity)")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                        .frame(minWidth: 30)

                    Button(action: {
                        cartManager.updateQuantity(cartItem: item, quantity: item.quantity + 1)
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(AppColors.primary)
                    }
                }

                Text("₹\(String(format: "%.0f", item.totalPrice))")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(AppColors.textSecondary)
            }
        }
        .padding(16)
        .background(AppColors.cardBackground)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

// MARK: - Checkout View
struct CheckoutView: View {
    @ObservedObject var cartManager = CartManager.shared
    @State private var orderPlaced = false
    @State private var placedOrder: Order?
    @Binding var selectedTab: TabItem
    @Binding var showToast: Bool
    @Binding var toastMessage: String
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()

            if orderPlaced, let order = placedOrder {
                // Order Success Screen
                VStack(spacing: 30) {
                    Spacer()

                    // Success Animation
                    ZStack {
                        Circle()
                            .fill(AppColors.success.opacity(0.2))
                            .frame(width: 120, height: 120)
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(AppColors.success)
                    }

                    VStack(spacing: 12) {
                        Text("Order Placed!")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(AppColors.textPrimary)

                        Text("Order #\(order.orderNumber)")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(AppColors.primary)

                        Text("₹\(String(format: "%.0f", order.totalAmount))")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(AppColors.textSecondary)
                    }

                    Text("Your order has been placed successfully!\nCheck the Orders tab to track your order.")
                        .font(.system(size: 16))
                        .foregroundColor(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)

                    Spacer()

                    Button(action: {
                        // Dismiss and go to Orders tab
                        isPresented = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            selectedTab = .orders
                        }
                    }) {
                        Text("View My Orders")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(colors: [AppColors.primary, AppColors.gradientEnd], startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(16)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            } else {
                // Checkout Screen
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(spacing: 24) {
                            // Order Summary
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Order Summary")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(AppColors.textPrimary)

                                ForEach(cartManager.cartItems) { item in
                                    HStack {
                                        Text(item.product.name)
                                            .font(.system(size: 16))
                                            .foregroundColor(AppColors.textPrimary)
                                        Spacer()
                                        Text("\(item.quantity)x")
                                            .font(.system(size: 14))
                                            .foregroundColor(AppColors.textSecondary)
                                        Text("₹\(String(format: "%.0f", item.totalPrice))")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(AppColors.primary)
                                    }
                                }

                                Divider()

                                HStack {
                                    Text("Subtotal")
                                        .font(.system(size: 16))
                                        .foregroundColor(AppColors.textSecondary)
                                    Spacer()
                                    Text("₹\(String(format: "%.0f", cartManager.cartTotal))")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(AppColors.textPrimary)
                                }

                                HStack {
                                    Text("Delivery Fee")
                                        .font(.system(size: 16))
                                        .foregroundColor(AppColors.textSecondary)
                                    Spacer()
                                    Text("FREE")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(AppColors.success)
                                }

                                Divider()

                                HStack {
                                    Text("Total Amount")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(AppColors.textPrimary)
                                    Spacer()
                                    Text("₹\(String(format: "%.0f", cartManager.cartTotal))")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(AppColors.primary)
                                }
                            }
                            .padding(20)
                            .background(AppColors.cardBackground)
                            .cornerRadius(20)

                            // Delivery Address
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Delivery Address")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(AppColors.textPrimary)

                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Home")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(AppColors.textPrimary)
                                    Text("123 Main Street, Bangalore")
                                        .font(.system(size: 14))
                                        .foregroundColor(AppColors.textSecondary)
                                    Text("Karnataka, 560001")
                                        .font(.system(size: 14))
                                        .foregroundColor(AppColors.textSecondary)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(20)
                            .background(AppColors.cardBackground)
                            .cornerRadius(20)

                            // Payment Method
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Payment Method")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(AppColors.textPrimary)

                                HStack {
                                    Image(systemName: "creditcard.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(AppColors.primary)
                                    Text("Cash on Delivery")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(AppColors.textPrimary)
                                    Spacer()
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(AppColors.success)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(20)
                            .background(AppColors.cardBackground)
                            .cornerRadius(20)
                        }
                        .padding(20)
                        .padding(.bottom, 100)
                    }

                    // Place Order Button (Fixed at Bottom)
                    VStack(spacing: 0) {
                        Button(action: placeOrder) {
                            HStack {
                                Text("Place Order")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(
                                LinearGradient(colors: [AppColors.success, AppColors.secondary], startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(16)
                            .shadow(color: AppColors.success.opacity(0.4), radius: 12, x: 0, y: 6)
                        }
                        .padding(20)
                    }
                    .background(
                        AppColors.cardBackground
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
                    )
                }
            }
        }
        .navigationBarTitle("Checkout", displayMode: .inline)
        .navigationBarItems(leading: Button(action: {
            isPresented = false
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .foregroundColor(AppColors.primary)
        })
    }

    private func placeOrder() {
        let order = cartManager.placeOrder()

        // Show success message
        toastMessage = "Order #\(order.orderNumber) placed successfully!"

        withAnimation(.spring()) {
            placedOrder = order
            orderPlaced = true
        }

        // After showing success, navigate to orders
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isPresented = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                selectedTab = .orders
                // Show toast on main screen
                withAnimation {
                    showToast = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation {
                        showToast = false
                    }
                }
            }
        }
    }
}

// MARK: - Toast View
struct ToastView: View {
    let message: String

    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 20))
                .foregroundColor(.white)
            Text(message)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(
            Capsule()
                .fill(AppColors.success)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        )
    }
}

// MARK: - Profile View
struct ProfileView: View {
    @State private var notificationsEnabled = true

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(LinearGradient(colors: [AppColors.primary, AppColors.secondary], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 100, height: 100)
                            Text("DM")
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(.white)
                        }

                        VStack(spacing: 4) {
                            Text("Dinakar Maurya")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(AppColors.textPrimary)
                            Text("dinkar1708@gmail.com")
                                .font(.system(size: 14))
                                .foregroundColor(AppColors.textSecondary)
                        }
                    }
                    .padding(.top, 40)

                    VStack(spacing: 16) {
                        ProfileMenuItem(icon: "person.fill", title: "Edit Profile", color: AppColors.primary)
                        ProfileMenuItem(icon: "bag.fill", title: "My Orders", color: AppColors.secondary)
                        ProfileMenuItem(icon: "heart.fill", title: "Favorites", color: AppColors.accent)

                        // Notifications with Toggle
                        ProfileMenuToggleItem(
                            icon: "bell.fill",
                            title: "Notifications",
                            color: AppColors.warning,
                            isOn: $notificationsEnabled
                        )

                        ProfileMenuItem(icon: "gear", title: "Settings", color: AppColors.info)
                    }
                    .padding(.horizontal, 20)

                    Spacer()
                }
            }
            .background(AppColors.background)
            .navigationBarHidden(true)
        }
    }
}

struct ProfileMenuItem: View {
    let icon: String
    let title: String
    let color: Color

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(color.opacity(0.15))
                    .frame(width: 48, height: 48)
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(color)
            }
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppColors.textPrimary)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(AppColors.textLight)
        }
        .padding()
        .background(AppColors.cardBackground)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

// MARK: - Profile Menu Item with Toggle
struct ProfileMenuToggleItem: View {
    let icon: String
    let title: String
    let color: Color
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(color.opacity(0.15))
                    .frame(width: 48, height: 48)
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(color)
            }
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppColors.textPrimary)
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: color))
        }
        .padding()
        .background(AppColors.cardBackground)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}
