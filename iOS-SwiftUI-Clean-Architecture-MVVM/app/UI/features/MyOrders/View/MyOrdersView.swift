//
//  MyOrdersView.swift
//  iOS-SwiftUI-Clean-Architecture-MVVM
//
//  Created by Dinakar Prasad Maurya on 2020/12/29.
//

import SwiftUI
/**
 https://developer.apple.com/documentation/swiftui/managing-model-data-in-your-app
 */
struct MyOrdersView: View {
    @ObservedObject var viewModel: MyOrdersViewModel
    @ObservedObject var cartManager = CartManager.shared

    var body: some View {
        NavigationView {
            ZStack {
                AppColors.background.ignoresSafeArea()

                if cartManager.orders.isEmpty {
                    // Empty State
                    VStack(spacing: 24) {
                        Image(systemName: "bag.badge.questionmark")
                            .font(.system(size: 70))
                            .foregroundColor(AppColors.textLight)
                            .padding()

                        VStack(spacing: 8) {
                            Text("No Orders Yet")
                                .font(.system(size: 26, weight: .bold))
                                .foregroundColor(AppColors.textPrimary)

                            Text("Start shopping to see your orders here")
                                .font(.system(size: 16))
                                .foregroundColor(AppColors.textSecondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    // Orders List
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(cartManager.orders) { order in
                                OrderCard(order: order)
                            }
                        }
                        .padding(20)
                        .padding(.bottom, 80)
                    }
                }
            }
            .navigationBarTitle("My Orders", displayMode: .large)
        }
    }
}

// MARK: - Order Card
struct OrderCard: View {
    let order: Order

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Order Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Order #\(order.orderNumber)")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                    Text(formatDate(order.date))
                        .font(.system(size: 14))
                        .foregroundColor(AppColors.textSecondary)
                }
                Spacer()
                StatusBadge(status: order.status)
            }

            Divider()

            // Order Items
            VStack(alignment: .leading, spacing: 8) {
                ForEach(order.items.prefix(2)) { item in
                    HStack {
                        Text(item.product.name)
                            .font(.system(size: 14))
                            .foregroundColor(AppColors.textSecondary)
                        Spacer()
                        Text("\(item.quantity)x")
                            .font(.system(size: 14))
                            .foregroundColor(AppColors.textSecondary)
                    }
                }
                if order.items.count > 2 {
                    Text("+ \(order.items.count - 2) more items")
                        .font(.system(size: 12))
                        .foregroundColor(AppColors.textLight)
                }
            }

            Divider()

            // Order Total
            HStack {
                Text("\(order.itemCount) items")
                    .font(.system(size: 14))
                    .foregroundColor(AppColors.textSecondary)
                Spacer()
                Text("Total: ₹\(String(format: "%.0f", order.totalAmount))")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(AppColors.primary)
            }
        }
        .padding(20)
        .background(AppColors.cardBackground)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 4)
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy 'at' hh:mm a"
        return formatter.string(from: date)
    }
}

// MARK: - Status Badge
struct StatusBadge: View {
    let status: String

    var body: some View {
        Text(status)
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(statusColor)
            .cornerRadius(8)
    }

    private var statusColor: Color {
        switch status.lowercased() {
        case "processing": return AppColors.warning
        case "delivered": return AppColors.success
        case "cancelled": return AppColors.error
        default: return AppColors.info
        }
    }
}

struct MyOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        List(ItemModel.getHomeMockData()) { model in
            NavigationLink(
                destination: OrderDetailsView(),
                label: { HStack { Text(model.name); Text(String(model.price)) }}
            )
        }
    }
}
