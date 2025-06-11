//
//  EditProfileIpadView.swift
//  LunarisIpad
//
//  Created by Calvin Laiman on 11/06/25.
//

import SwiftUI
import SwiftData

struct EditProfileIpadView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var context

    var user: UserModel

    @State private var draftUsername: String
    @State private var errorMessage: String?

    private var userViewModel: UserViewModel

    init(user: UserModel, modelContext: ModelContext) {
        self.user = user
        _draftUsername = State(initialValue: user.username)
        self.userViewModel = UserViewModel(context: modelContext)
    }

    init(user: UserModel) {
        self.user = user
        _draftUsername = State(initialValue: user.username)
        let previewContainer = try! ModelContainer(for: UserModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.userViewModel = UserViewModel(context: previewContainer.mainContext)
    }

    var body: some View {
        ZStack {
            Image("Login")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                    Spacer()
                    Text("Edit Profile")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    Spacer()
                    Button(action: {
                        saveProfileChanges()
                    }) {
                        Text("Save")
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .disabled(isSaveButtonDisabled())
                }
                .padding(.horizontal, 60)
                .padding(.top, 60)
                .padding(.bottom, 30)

                ScrollView {
                    VStack(spacing: 30) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("USERNAME")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.7))
                                .padding(.leading, 5)

                            TextField("Enter username", text: $draftUsername)
                                .foregroundColor(.white)
                                .font(.title3)
                                .padding()
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                )
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        .padding(.horizontal, 80)

                        if let msg = errorMessage {
                            Text(msg)
                                .font(.callout)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 80)
                        }

                        Spacer(minLength: 100)
                    }
                    .padding(.top, 30)
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func isSaveButtonDisabled() -> Bool {
        let trimmed = draftUsername.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty || trimmed == user.username
    }

    private func saveProfileChanges() {
        errorMessage = nil
        let trimmed = draftUsername.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmed.isEmpty {
            errorMessage = "Username cannot be empty."
            return
        }

        if trimmed == user.username {
            errorMessage = "No changes to save."
            return
        }
    }
}

#Preview {
    let user = UserModel(userId: 1, username: "PreviewUser", password: "123")
    return EditProfileIpadView(user: user)
        .modelContainer(for: UserModel.self, inMemory: true)
}
