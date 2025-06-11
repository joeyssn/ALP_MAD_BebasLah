//
//  MacLoginView.swift
//  LunarisMac
//
//  Created by Christianto Elvern Haryanto on 11/06/25.
//

import SwiftUI
import SwiftData

struct MacLoginView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var sessionController: SessionController
    @EnvironmentObject var userController: UserController

    @State private var username = ""
    @State private var password = ""
    @State private var isRegistering = false
    @State private var errorMessage = ""
    @State private var isLoading = false
    @State private var showPassword = false
    @State private var rememberMe = false
    @State private var animateGradient = false
    @State private var logoRotation: Double = 0
    @State private var formOpacity: Double = 0
    @State private var backgroundOffset: CGFloat = 0
    @FocusState private var focusedField: Field?
    private let particles = (0..<15).map { _ in Particle.random() }

    enum Field {
        case username, password
    }

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                // Left side - Background image with welcome content
                ZStack {
                    // Background image
                    Image("Login")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width * 0.6, height: geometry.size.height)
                        .offset(x: backgroundOffset)
                        .clipped()
                        .animation(.easeInOut(duration: 20).repeatForever(autoreverses: true), value: backgroundOffset)

                    // Gradient overlay
                    LinearGradient(
                        colors: [.black.opacity(0.4), .blue.opacity(0.2), .purple.opacity(0.1), .clear],
                        startPoint: .leading,
                        endPoint: .trailing
                    )

                    // Floating particles
                    TimelineView(.animation) { timeline in
                        ForEach(particles) { particle in
                            Circle()
                                .fill(Color.white.opacity(0.1))
                                .frame(width: particle.size)
                                .offset(
                                    x: particle.x,
                                    y: particle.y + sin(timeline.date.timeIntervalSinceReferenceDate * particle.speed) * 20
                                )
                        }
                    }

                    // Welcome content
                    WelcomeSection()
                        .padding(.horizontal, 60)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                .frame(width: geometry.size.width * 0.6)

                // Right side - Login Form
                VStack(spacing: 0) {
                    Spacer()
                    
                    VStack(spacing: 32) {
                        // Logo and title
                        VStack(spacing: 16) {
                            Image(systemName: "moon.circle.fill")
                                .resizable()
                                .frame(width: 64, height: 64)
                                .rotationEffect(.degrees(logoRotation))
                                .animation(.easeInOut(duration: 0.8), value: logoRotation)
                                .foregroundStyle(.blue)

                            Text(isRegistering ? "Create Account" : "Sign In")
                                .font(.title.bold())
                                .foregroundColor(.primary)
                        }

                        // Form fields
                        VStack(spacing: 20) {
                            // Username field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Username")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                TextField("Enter your username", text: $username)
                                    .textFieldStyle(.roundedBorder)
                                    .focused($focusedField, equals: .username)
                                    .onSubmit {
                                        focusedField = .password
                                    }
                            }

                            // Password field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Password")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                HStack {
                                    Group {
                                        if showPassword {
                                            TextField("Enter your password", text: $password)
                                        } else {
                                            SecureField("Enter your password", text: $password)
                                        }
                                    }
                                    .focused($focusedField, equals: .password)
                                    .onSubmit {
                                        handleAuthAction()
                                    }

                                    Button(action: { showPassword.toggle() }) {
                                        Image(systemName: showPassword ? "eye.slash" : "eye")
                                            .foregroundColor(.gray)
                                    }
                                    .buttonStyle(.plain)
                                }
                                .textFieldStyle(.roundedBorder)
                            }

                            // Error message
                            if !errorMessage.isEmpty {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }

                            // Remember me and toggle
                            HStack {
                                Toggle("Remember me", isOn: $rememberMe)
                                    .toggleStyle(.checkbox)
                                
                                Spacer()
                                
                                Button(isRegistering ? "Have an account?" : "New here?") {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        isRegistering.toggle()
                                        errorMessage = ""
                                    }
                                }
                                .buttonStyle(.link)
                            }

                            // Login/Register button
                            Button(action: handleAuthAction) {
                                HStack(spacing: 8) {
                                    if isLoading {
                                        ProgressView()
                                            .progressViewStyle(.circular)
                                            .scaleEffect(0.8)
                                    }
                                    Text(isRegistering ? "Create Account" : "Sign In")
                                        .bold()
                                        .font(.headline)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(isLoading ? Color.gray : Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            }
                            .disabled(isLoading || username.isEmpty || password.isEmpty)
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 48)
                    .frame(maxWidth: 400)
                    
                    Spacer()
                }
                .frame(width: geometry.size.width * 0.4)
                .background(Color(NSColor.controlBackgroundColor))
                .opacity(formOpacity)
            }
        }
        .frame(minWidth: 1200, minHeight: 800)
        .onAppear {
            focusedField = .username
            withAnimation(.easeOut(duration: 1.2)) {
                formOpacity = 1.0
            }
            animateGradient = true
            backgroundOffset = 10
        }
    }

    private func handleAuthAction() {
        guard !isLoading else { return }
        guard !username.isEmpty && !password.isEmpty else { return }
        
        isLoading = true
        errorMessage = ""
        
        withAnimation(.easeInOut(duration: 0.5)) {
            logoRotation += 360
        }
        
        Task {
            try? await Task.sleep(nanoseconds: 800_000_000) // 0.8s delay
            
            await MainActor.run {
                do {
                    if isRegistering {
                        let success = try userController.register(username: username, password: password)
                        if !success {
                            errorMessage = "Username already exists. Please choose a different username."
                            isLoading = false
                            return
                        }
                        // Auto-login after registration
                        if let user = try userController.login(username: username, password: password) {
                            sessionController.currentUser = user
                            withAnimation {
                                isRegistering = false
                            }
                            username = ""
                            password = ""
                        }
                    } else {
                        // ✅ Handle login flow
                        if let user = try userController.login(username: username, password: password) {
                            sessionController.currentUser = user
                            username = ""
                            password = ""
                        } else {
                            errorMessage = "Invalid username or password."
                        }
                    }
                    
                    isLoading = false
                } catch {
                    errorMessage = error.localizedDescription
                    isLoading = false
                }
            }
        }
    }
}

// MARK: - Particle

struct Particle: Identifiable {
    let id = UUID()
    let x: CGFloat
    let y: CGFloat
    let size: CGFloat
    let speed: Double

    static func random() -> Particle {
        Particle(
            x: CGFloat.random(in: -200...200),
            y: CGFloat.random(in: -300...300),
            size: CGFloat.random(in: 2...8),
            speed: Double.random(in: 1.5...3.0)
        )
    }
}

// MARK: - WelcomeSection

struct WelcomeSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Spacer()

            VStack(alignment: .leading, spacing: 16) {
                Text("Welcome back")
                    .font(.system(size: 48, weight: .light, design: .rounded))
                    .foregroundStyle(LinearGradient(colors: [.white, .blue.opacity(0.8)], startPoint: .leading, endPoint: .trailing))
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)

                Text("Sign in to continue your journey with Lunaris")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.white.opacity(0.9))
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)

                VStack(alignment: .leading, spacing: 12) {
                    FeatureRow(icon: "moon.stars.fill", text: "Personalized lunar insights")
                    FeatureRow(icon: "chart.line.uptrend.xyaxis", text: "Advanced analytics")
                    FeatureRow(icon: "lock.shield.fill", text: "Secure data protection")
                }
                .padding(.top, 24)
            }

            Spacer()
            Spacer()
        }
    }
}

// Helper view for feature highlights
struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.white.opacity(0.8))
                .font(.system(size: 16))
                .frame(width: 20)
            
            Text(text)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white.opacity(0.9))
        }
    }
}

#Preview {
    MacLoginView()
        .frame(width: 1200, height: 800)
}
