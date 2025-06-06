//
//  EditProfileView.swift
//  ALP_MAD_Joey
//
//  Created by Kevin Christian on 05/06/25.
//

import SwiftUI
import SwiftData

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var context // Used to initialize UserController

    var user: UserModel

    @State private var draftUsername: String
    @State private var errorMessage: String?

    private var userController: UserController

    // Initializer for use in the app flow, receiving the modelContext
    init(user: UserModel, modelContext: ModelContext) {
        self.user = user
        _draftUsername = State(initialValue: user.username)
        self.userController = UserController(context: modelContext)
    }
    
    // Convenience initializer for previews, creates a temporary context
    init(user: UserModel) {
        self.user = user
        _draftUsername = State(initialValue: user.username)
        // This preview-specific init assumes the #Preview block will provide a .modelContainer
        // If not, UserController might not have a valid context.
        // A robust way is to ensure previews always get a container.
        let previewContainer = try! ModelContainer(for: UserModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.userController = UserController(context: previewContainer.mainContext)
    }


    var body: some View {
        ZStack {
            Image("Login") // Ensure "Login" image is in your assets
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Custom Top Bar
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark") // Changed from chevron for "cancel" feel
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                    Spacer()
                    Text("Edit Profile")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    Button(action: {
                        saveProfileChanges()
                    }) {
                        Text("Save")
                            .foregroundColor(.white)
                            .fontWeight(.semibold) // Make save button text bold
                            .font(.headline) // Use headline font for save
                    }
                    .disabled(isSaveButtonDisabled())
                }
                .padding(.horizontal)
                .padding(.top, 50) // Adjust for safe area / notch
                .padding(.bottom, 20) // Space between top bar and content

                // Form Content
                ScrollView {
                    VStack(spacing: 20) { // Spacing between form elements
                        // Username Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("USERNAME")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                                .padding(.leading, 5) // Small indent for the label

                            TextField("Enter username", text: $draftUsername)
                                .foregroundColor(.white) // Text color for input
                                .padding() // Inner padding for the TextField
                                .background(Color.white.opacity(0.1)) // Semi-transparent background
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1) // Subtle border
                                )
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        .padding(.horizontal) // Horizontal padding for the username section
                        
                        // Display error message if any
                        if let msg = errorMessage {
                            Text(msg)
                                .font(.caption)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading) // Align text left
                                .padding(.horizontal) // Match padding of fields
                                .padding(.top, 5) // Some space above the error message
                        }
                        
                        Spacer() // Pushes content up if not enough to fill the screen
                    }
                    .padding(.top, 20) // Padding from top bar to the start of form content
                }
            }
        }
        .navigationBarHidden(true) // We are using a custom top bar
    }

    private func isSaveButtonDisabled() -> Bool {
        let trimmedUsername = draftUsername.trimmingCharacters(in: .whitespacesAndNewlines)
        // Disable if username is empty or unchanged
        return trimmedUsername.isEmpty || trimmedUsername == user.username
    }

    private func saveProfileChanges() {
        errorMessage = nil // Reset error message
        let trimmedUsername = draftUsername.trimmingCharacters(in: .whitespacesAndNewlines)

        // Validate username
        if trimmedUsername.isEmpty {
            errorMessage = "Username cannot be empty."
            return
        }
        
        // Check if username has actually changed
        if user.username == trimmedUsername {
            errorMessage = "No changes to save."
            // Optionally dismiss or just show the message
            // presentationMode.wrappedValue.dismiss()
            return
        }
       
    }
}
