//
//  LoginRegisterView.swift
//  ALP_MAD_Joey
//
//  Created by student on 22/05/25.
//

import SwiftUI

struct LoginRegisterView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isRegistering = false

    var body: some View {
        ZStack {
            Image("Login")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()

            VStack {
                Image("Logo")
                    .resizable()
                    .ignoresSafeArea()
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
                        .accentColor(Color(red: 125/255, green: 125/255, blue: 125/255))
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
                        .accentColor(Color(red: 125/255, green: 125/255, blue: 125/255))
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)
                .padding(.bottom, 20)


                // Login/Register Button
                Button(action: {
                    // Handle action
                }) {
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
                }) {
                    Text(isRegistering
                         ? "Already have an account? Log in"
                         : "Don't have an account? Register")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding(.top, 10)
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    LoginRegisterView()
}
