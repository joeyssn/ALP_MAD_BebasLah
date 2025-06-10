//
//  LoginRegisterIpadView.swift
//  LunarisIpad
//
//  Created by Calvin Laiman on 11/06/25.
//

import SwiftUI
import SwiftData

struct LoginRegisterIpadView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var sessionController: SessionController
    @EnvironmentObject var userController: UserController

    @State private var username = ""
    @State private var password = ""
    @State private var isRegistering = false
    @State private var errorMessage = ""

    var body: some View {
        ZStack {
            Image("Login")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()

            VStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 300, height: 300)

                HStack(spacing: 0) {
                    Text("Welcome to ")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.white)

                    Text("Lunaris")
                        .font(.system(size: 35, weight: .bold))
                        .overlay(
                            LinearGradient(
                                colors: [.white, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .mask(
                                Text("Lunaris")
                                    .font(.system(size: 35, weight: .bold))
                            )
                        )
                }
                .padding(.bottom, 20)

                // Username
                ZStack(alignment: .leading) {
                    if username.isEmpty {
                        Text("Username")
                            .foregroundColor(.gray)
                    }

                    TextField("", text: $username)
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)

                // Password
                ZStack(alignment: .leading) {
                    if password.isEmpty {
                        Text("Password")
                            .foregroundColor(.gray)
                    }

                    SecureField("", text: $password)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)
                .padding(.bottom, 20)

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .padding(.bottom, 8)
                }

                // Login/Register Button
                Button(action: handleAuthAction) {
                    Text(isRegistering ? "REGISTER" : "LOG IN")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .padding(.bottom, 24)
                }

                // Toggle Button
                Button(action: {
                    isRegistering.toggle()
                    errorMessage = ""
                }) {
                    Text(isRegistering
                         ? "Already have an account? Log in"
                         : "Don't have an account? Register")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding(.top, 10)
            }
            .padding(.horizontal, 200) // Tambahan padding untuk iPad
        }
    }

    private func handleAuthAction() {
        do {
            if isRegistering {
                let success = try userController.register(username: username, password: password)
                if !success {
                    errorMessage = "Username already exists."
                    return
                }
                if let user = try userController.login(username: username, password: password) {
                    sessionController.currentUser = user
                }
            } else {
                guard let user = try userController.login(username: username, password: password) else {
                    errorMessage = "Invalid username or password."
                    return
                }
                sessionController.currentUser = user
            }

            errorMessage = ""
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    LoginRegisterIpadView()
        .environmentObject(SessionController())
        .modelContainer(for: [UserModel.self], inMemory: true)
}
