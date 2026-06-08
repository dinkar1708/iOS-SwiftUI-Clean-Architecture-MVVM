//
//  ModernProductCard.swift
//  iOS-SwiftUI-Clean-Architecture-MVVM
//
//  Beautiful Product Card Component
//

import SwiftUI

struct ModernProductCard: View {
    let model: ItemModel
    @State private var isPressed = false

    var body: some View {
        NavigationLink(destination: OrderDetailsView()) {
            HStack(spacing: 16) {
                // Product Image Placeholder
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: [
                                    AppColors.primary.opacity(0.3),
                                    AppColors.secondary.opacity(0.3)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 80, height: 80)

                    Image(systemName: productIcon)
                        .font(.system(size: 36))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [AppColors.primary, AppColors.secondary],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }

                // Product Details
                VStack(alignment: .leading, spacing: 8) {
                    Text(model.name)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                        .lineLimit(1)

                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 12))
                            .foregroundColor(AppColors.warning)

                        Text("4.8")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(AppColors.textSecondary)

                        Text("(120 reviews)")
                            .font(.system(size: 12))
                            .foregroundColor(AppColors.textLight)
                    }

                    HStack {
                        Text("$\(String(format: "%.2f", model.price))")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [AppColors.primary, AppColors.secondary],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )

                        Spacer()

                        // Add to Cart Button
                        Button(action: {
                            withAnimation(.spring(response: 0.3)) {
                                isPressed.toggle()
                            }
                        }) {
                            ZStack {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [AppColors.primary, AppColors.gradientEnd],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 36, height: 36)
                                    .shadow(color: AppColors.primary.opacity(0.4), radius: 8, x: 0, y: 4)

                                Image(systemName: isPressed ? "checkmark" : "plus")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                        .scaleEffect(isPressed ? 0.9 : 1.0)
                    }
                }

                Spacer()
            }
            .padding(16)
            .background(AppColors.cardBackground)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 4)
        }
        .buttonStyle(ProductCardButtonStyle())
    }

    private var productIcon: String {
        let icons = ["bag.fill", "cart.fill", "gift.fill", "tshirt.fill", "book.fill", "gamecontroller.fill"]
        return icons[abs(model.name.hashValue) % icons.count]
    }
}

// Custom button style for card press effect
struct ProductCardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

struct ModernProductCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ModernProductCard(model: ItemModel(id: 1, name: "Premium Headphones", price: 99.99))
                .padding()

            ModernProductCard(model: ItemModel(id: 2, name: "Smart Watch", price: 299.99))
                .padding()
        }
        .background(AppColors.background)
    }
}
