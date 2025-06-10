//
//  WatchLoginView.swift
//  LunarisWatch Watch App
//
//  Created by Christianto Elvern Haryanto on 11/06/25.
//

import SwiftUI
import SwiftData

struct WatchLoginView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var sessionController: WatchSessionViewModel
    @EnvironmentObject var watchUserViewModel: WatchUserViewModel

    @State private var username = ""
    @State private var password = ""
    @State private var isRegistering = false
    @State private var errorMessage = ""
    @State private var showingUsernameInput = false
    @State private var showingPasswordInput = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    // Logo and Title
                    VStack(spacing: 8) {
                        Image("Logo")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(8)

                        Text("Lunaris")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.white, .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    }
                    .padding(.bottom, 8)

                    // Username Input
                    Button {
                        showingUsernameInput = true
                    } label: {
                        HStack {
                            Image(systemName: "person")
                                .foregroundColor(.gray)
                            Text(username.isEmpty ? "Username" : username)
                                .foregroundColor(username.isEmpty ? .gray : .white)
                                .lineLimit(1)
                            Spacer()
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8)
                    }
                    .sheet(isPresented: $showingUsernameInput) {
                        TextFieldSheet(
                            title: "Username",
                            text: $username,
                            placeholder: "Enter username"
                        )
                    }

                    // Password Input
                    Button {
                        showingPasswordInput = true
                    } label: {
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.gray)
                            Text(password.isEmpty ? "Password" : String(repeating: "•", count: password.count))
                                .foregroundColor(password.isEmpty ? .gray : .white)
                                .lineLimit(1)
                            Spacer()
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8)
                    }
                    .sheet(isPresented: $showingPasswordInput) {
                        SecureFieldSheet(
                            title: "Password",
                            text: $password,
                            placeholder: "Enter password"
                        )
                    }

                    // Error Message
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption2)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 4)
                    }

                    // Login/Register Button
                    Button(action: handleAuthAction) {
                        Text(isRegistering ? "REGISTER" : "LOG IN")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                    }
                    .disabled(username.isEmpty || password.isEmpty)

                    // Toggle Button
                    Button {
                        isRegistering.toggle()
                        errorMessage = ""
                    } label: {
                        Text(isRegistering ? "Have account? Log in" : "No account? Register")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.7))
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
        }
    }

    private func handleAuthAction() {
        do {
            if isRegistering {
                let success = try watchUserViewModel.register(username: username, password: password)
                if !success {
                    errorMessage = "Username exists."
                    return
                }
            }

            guard let user = try watchUserViewModel.login(username: username, password: password) else {
                errorMessage = "Invalid credentials."
                return
            }

            sessionController.currentUser = user
            errorMessage = ""
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

// MARK: - Helper Views for Text Input

struct TextFieldSheet: View {
    let title: String
    @Binding var text: String
    let placeholder: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                TextField(placeholder, text: $text)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)

                Button("Done") {
                    dismiss()
                }
                .padding(.top)
            }
            .padding()
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SecureFieldSheet: View {
    let title: String
    @Binding var text: String
    let placeholder: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                SecureField(placeholder, text: $text)
                    .textFieldStyle(.roundedBorder)

                Button("Done") {
                    dismiss()
                }
                .padding(.top)
            }
            .padding()
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Preview with Required Dependencies

#Preview {
    let container = try! ModelContainer(for: UserModel.self)
    let watchUserViewModel = WatchUserViewModel(context: container.mainContext)
    let sessionController = WatchSessionViewModel()

    WatchLoginView()
        .modelContainer(container)
        .environmentObject(watchUserViewModel)
        .environmentObject(sessionController)
}
