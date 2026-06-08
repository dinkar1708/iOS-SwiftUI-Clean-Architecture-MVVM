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
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeOut(duration: 0.5)) {
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

    var body: some View {
        ZStack(alignment: .bottom) {
            AppColors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                tabContent.frame(maxWidth: .infinity, maxHeight: .infinity)
            }

            CustomTabBar(selectedTab: $selectedTab)
        }
    }

    @ViewBuilder
    private var tabContent: some View {
        switch selectedTab {
        case .home: EnhancedHomeView()
        case .orders: MyOrdersView(viewModel: MyOrdersViewModel())
        case .cart: CartView()
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
                            Button("See All") {}
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(AppColors.primary)
                        }
                        .padding(.horizontal, 20)

                        MyOrdersView(viewModel: MyOrdersViewModel())
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
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "cart.fill")
                    .font(.system(size: 60))
                    .foregroundColor(AppColors.primary)
                    .padding()
                Text("Your Cart")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                Text("Add items to get started")
                    .font(.system(size: 16))
                    .foregroundColor(AppColors.textSecondary)
                    .padding(.top, 4)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColors.background)
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Profile View
struct ProfileView: View {
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
                            Text("dinakar@example.com")
                                .font(.system(size: 14))
                                .foregroundColor(AppColors.textSecondary)
                        }
                    }
                    .padding(.top, 40)

                    VStack(spacing: 16) {
                        ProfileMenuItem(icon: "person.fill", title: "Edit Profile", color: AppColors.primary)
                        ProfileMenuItem(icon: "bag.fill", title: "My Orders", color: AppColors.secondary)
                        ProfileMenuItem(icon: "heart.fill", title: "Favorites", color: AppColors.accent)
                        ProfileMenuItem(icon: "bell.fill", title: "Notifications", color: AppColors.warning)
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
