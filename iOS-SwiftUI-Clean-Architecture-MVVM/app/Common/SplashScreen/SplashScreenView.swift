//
//  SplashScreenView.swift
//  iOS-SwiftUI-Clean-Architecture-MVVM
//
//  Beautiful Animated Splash Screen
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var logoScale: CGFloat = 0.5
    @State private var logoOpacity: Double = 0
    @State private var circleScale: CGFloat = 0.5
    @State private var backgroundOpacity: Double = 1
    @State private var particlesOpacity: Double = 0

    var body: some View {
        if isActive {
            MainTabView()
        } else {
            ZStack {
                // Gradient Background
                LinearGradient(
                    colors: [
                        AppColors.primary,
                        AppColors.gradientEnd,
                        AppColors.secondary
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                .opacity(backgroundOpacity)

                // Animated Circles Background
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.1))
                        .frame(width: 300, height: 300)
                        .offset(x: -100, y: -150)
                        .scaleEffect(circleScale)

                    Circle()
                        .fill(Color.white.opacity(0.08))
                        .frame(width: 250, height: 250)
                        .offset(x: 120, y: 180)
                        .scaleEffect(circleScale)

                    Circle()
                        .fill(Color.white.opacity(0.06))
                        .frame(width: 200, height: 200)
                        .offset(x: -80, y: 200)
                        .scaleEffect(circleScale)
                }
                .blur(radius: 20)

                // Particles Effect
                ParticlesView()
                    .opacity(particlesOpacity)

                // Main Content
                VStack(spacing: 24) {
                    // Logo Icon
                    ZStack {
                        // Outer Ring
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.5), Color.white.opacity(0.1)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 3
                            )
                            .frame(width: 140, height: 140)
                            .scaleEffect(logoScale)

                        // Inner Circle
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.2), Color.white.opacity(0.05)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(width: 120, height: 120)
                            .scaleEffect(logoScale)

                        // Icon
                        Image(systemName: "bag.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70, height: 70)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.white, Color.white.opacity(0.8)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .scaleEffect(logoScale)
                            .opacity(logoOpacity)
                    }

                    // App Name
                    VStack(spacing: 8) {
                        Text("Market")
                            .font(.system(size: 42, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .scaleEffect(logoScale)
                            .opacity(logoOpacity)

                        Text("Your Premium Shopping Experience")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white.opacity(0.9))
                            .opacity(logoOpacity)
                    }

                    // Loading Indicator
                    LoadingDotsView()
                        .padding(.top, 40)
                        .opacity(logoOpacity)
                }
            }
            .onAppear {
                startAnimations()
            }
        }
    }

    private func startAnimations() {
        // Logo and circle scale animation
        withAnimation(.spring(response: 0.8, dampingFraction: 0.6, blendDuration: 0)) {
            logoScale = 1.0
            circleScale = 1.0
        }

        // Logo opacity animation
        withAnimation(.easeIn(duration: 0.6)) {
            logoOpacity = 1.0
        }

        // Particles animation
        withAnimation(.easeIn(duration: 0.8).delay(0.3)) {
            particlesOpacity = 1.0
        }

        // Transition to main app
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeOut(duration: 0.5)) {
                backgroundOpacity = 0
                logoOpacity = 0
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isActive = true
            }
        }
    }
}

// Loading Dots Animation
struct LoadingDotsView: View {
    @State private var animating = false

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(.white)
                    .frame(width: 8, height: 8)
                    .scaleEffect(animating ? 1.0 : 0.5)
                    .opacity(animating ? 1.0 : 0.3)
                    .animation(
                        .easeInOut(duration: 0.6)
                        .repeatForever()
                        .delay(Double(index) * 0.2),
                        value: animating
                    )
            }
        }
        .onAppear {
            animating = true
        }
    }
}

// Particles Effect
struct ParticlesView: View {
    @State private var particles: [Particle] = []

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(particles) { particle in
                    Circle()
                        .fill(.white)
                        .frame(width: particle.size, height: particle.size)
                        .position(particle.position)
                        .opacity(particle.opacity)
                }
            }
            .onAppear {
                generateParticles(in: geometry.size)
            }
        }
    }

    private func generateParticles(in size: CGSize) {
        particles = (0..<30).map { _ in
            Particle(
                position: CGPoint(
                    x: CGFloat.random(in: 0...size.width),
                    y: CGFloat.random(in: 0...size.height)
                ),
                size: CGFloat.random(in: 2...6),
                opacity: Double.random(in: 0.1...0.4)
            )
        }
    }
}

struct Particle: Identifiable {
    let id = UUID()
    let position: CGPoint
    let size: CGFloat
    let opacity: Double
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
