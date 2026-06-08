//
//  AppTheme.swift
//  iOS-SwiftUI-Clean-Architecture-MVVM
//
//  Modern UI Theme - Colors, Tab Bar, and Components
//

import SwiftUI

// MARK: - App Colors
struct AppColors {
    static let primary = Color(hex: "6C5CE7")
    static let secondary = Color(hex: "00B894")
    static let accent = Color(hex: "FD79A8")
    static let background = Color(hex: "F8F9FA")
    static let cardBackground = Color.white
    static let tabBarBackground = Color.white
    static let tabBarSelected = Color(hex: "6C5CE7")
    static let tabBarUnselected = Color(hex: "B2BEC3")
    static let textPrimary = Color(hex: "2D3436")
    static let textSecondary = Color(hex: "636E72")
    static let textLight = Color(hex: "B2BEC3")
    static let success = Color(hex: "00B894")
    static let warning = Color(hex: "FDCB6E")
    static let error = Color(hex: "FF7675")
    static let info = Color(hex: "74B9FF")
    static let gradientStart = Color(hex: "6C5CE7")
    static let gradientEnd = Color(hex: "A29BFE")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}

// MARK: - Tab Items
enum TabItem: String, CaseIterable {
    case home = "Home"
    case orders = "Orders"
    case cart = "Cart"
    case profile = "Profile"

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .orders: return "bag.fill"
        case .cart: return "cart.fill"
        case .profile: return "person.fill"
        }
    }

    var iconUnselected: String {
        switch self {
        case .home: return "house"
        case .orders: return "bag"
        case .cart: return "cart"
        case .profile: return "person"
        }
    }
}

// MARK: - Custom Tab Bar
struct CustomTabBar: View {
    @Binding var selectedTab: TabItem
    @Namespace private var animation

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(TabItem.allCases, id: \.self) { tab in
                    TabBarButton(tab: tab, isSelected: selectedTab == tab, animation: animation) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedTab = tab
                        }
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.top, 12)
            .padding(.bottom, 8)
        }
        .background(
            AppColors.tabBarBackground
                .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: -5)
                .ignoresSafeArea(edges: .bottom)
        )
        .cornerRadius(24, corners: [.topLeft, .topRight])
    }
}

struct TabBarButton: View {
    let tab: TabItem
    let isSelected: Bool
    let animation: Namespace.ID
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                ZStack {
                    if isSelected {
                        Capsule()
                            .fill(AppColors.tabBarSelected.opacity(0.15))
                            .frame(width: 60, height: 36)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                    Image(systemName: isSelected ? tab.icon : tab.iconUnselected)
                        .font(.system(size: 22, weight: isSelected ? .semibold : .regular))
                        .foregroundColor(isSelected ? AppColors.tabBarSelected : AppColors.tabBarUnselected)
                        .frame(width: 60, height: 36)
                }
                Text(tab.rawValue)
                    .font(.system(size: 11, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? AppColors.tabBarSelected : AppColors.tabBarUnselected)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Corner Radius Helper
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// MARK: - Product Card
struct ProductCard: View {
    let model: ItemModel
    @State private var isAdded = false
    @ObservedObject var cartManager = CartManager.shared

    var body: some View {
        HStack(spacing: 16) {
            // Product Image
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(LinearGradient(colors: [AppColors.primary.opacity(0.3), AppColors.secondary.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 80, height: 80)
                Image(systemName: productIcon)
                    .font(.system(size: 36))
                    .foregroundColor(AppColors.primary)
            }

            // Product Details
            VStack(alignment: .leading, spacing: 8) {
                Text(model.name)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                    .lineLimit(2)

                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                        .foregroundColor(AppColors.warning)
                    Text("4.8")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(AppColors.textSecondary)
                    Text("(120)")
                        .font(.system(size: 12))
                        .foregroundColor(AppColors.textLight)
                }

                HStack {
                    Text("₹\(String(format: "%.0f", model.price))")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(AppColors.primary)

                    Spacer()

                    // Add to Cart Button
                    Button(action: {
                        addToCart()
                    }) {
                        ZStack {
                            Circle()
                                .fill(LinearGradient(colors: [isAdded ? AppColors.success : AppColors.primary, isAdded ? AppColors.success : AppColors.gradientEnd], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 36, height: 36)
                                .shadow(color: (isAdded ? AppColors.success : AppColors.primary).opacity(0.4), radius: 8, x: 0, y: 4)
                            Image(systemName: isAdded ? "checkmark" : "plus")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    .scaleEffect(isAdded ? 0.9 : 1.0)
                }
            }
            Spacer()
        }
        .padding(16)
        .background(AppColors.cardBackground)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 4)
    }

    private func addToCart() {
        cartManager.addToCart(product: model)
        withAnimation(.spring(response: 0.3)) {
            isAdded = true
        }
        // Reset after 1 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation {
                isAdded = false
            }
        }
    }

    private var productIcon: String {
        let icons = ["iphone", "laptopcomputer", "headphones", "applewatch", "camera.fill", "gamecontroller.fill"]
        return icons[abs(model.name.hashValue) % icons.count]
    }
}

struct CardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isPressed)
    }
}
