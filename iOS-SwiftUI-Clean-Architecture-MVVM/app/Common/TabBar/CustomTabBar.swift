//
//  CustomTabBar.swift
//  iOS-SwiftUI-Clean-Architecture-MVVM
//
//  Modern Bottom Tab Bar with Beautiful Design
//

import SwiftUI

enum TabItem: String, CaseIterable {
    case home = "Home"
    case orders = "Orders"
    case cart = "Cart"
    case profile = "Profile"

    var icon: String {
        switch self {
        case .home:
            return "house.fill"
        case .orders:
            return "bag.fill"
        case .cart:
            return "cart.fill"
        case .profile:
            return "person.fill"
        }
    }

    var iconUnselected: String {
        switch self {
        case .home:
            return "house"
        case .orders:
            return "bag"
        case .cart:
            return "cart"
        case .profile:
            return "person"
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabItem
    @Namespace private var animation

    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabItem.allCases, id: \.self) { tab in
                TabBarButton(
                    tab: tab,
                    isSelected: selectedTab == tab,
                    animation: animation
                ) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedTab = tab
                    }
                }
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 12)
        .background(
            AppColors.tabBarBackground
                .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: -5)
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

// Helper to round specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            CustomTabBar(selectedTab: .constant(.home))
        }
        .background(AppColors.background)
    }
}
