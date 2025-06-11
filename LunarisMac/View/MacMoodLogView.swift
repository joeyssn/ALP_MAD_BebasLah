import SwiftData
import SwiftUI

struct MoodLogView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var sessionController: SessionController
    @EnvironmentObject var moodController: MoodController
    @Environment(\.dismiss) private var dismiss

    @State private var moods: [MoodModel] = []
    @State private var showMoodView = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                Image("Login")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .ignoresSafeArea()

                VStack(spacing: 16) { // Reduced spacing from 20 to 16
                    // Header
//                    HStack {
//                        Button("Back") {
//                            dismiss()
//                        }
//                        .foregroundColor(.white)
//                        .buttonStyle(.plain)
//                        
//                        Spacer()
//                    }
//                    .padding(.horizontal, 20)
//                    .padding(.top, 10) // Reduced top padding

                    // Title
                    VStack(spacing: 8) { // Reduced spacing
                        Text("Moods")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text("See all of your logged moods here")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                    }

                    // Content - Make this flexible
                    if moods.isEmpty {
                        VStack(spacing: 16) { // Reduced spacing
                            Image(systemName: "face.smiling")
                                .font(.system(size: 50)) // Reduced size
                                .foregroundColor(.white.opacity(0.6))

                            Text("No moods logged yet")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.8))

                            Text("Start tracking your daily emotions")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.6))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: .infinity) // Allow it to expand
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 12) { // Reduced spacing
                                ForEach(moods, id: \.id) { mood in
                                    HStack {
                                        Circle()
                                            .fill(colorForMood(mood.moodName))
                                            .frame(width: 16, height: 16)

                                        Text(mood.moodName)
                                            .foregroundColor(.white)
                                            .font(.headline)

                                        Spacer()

                                        Text(mood.dateLogged.formatted(date: .abbreviated, time: .shortened))
                                            .foregroundColor(.white.opacity(0.6))
                                            .font(.caption)
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    .background(Color.white.opacity(0.1))
                                    .cornerRadius(12)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .frame(maxHeight: min(geometry.size.height * 0.4, 300)) // Responsive height
                    }

                    // Simple Add Mood Button - Always at bottom
                    Button("Add Your Mood") {
                        showMoodView = true
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.purple)
                    .cornerRadius(12)
//                    .padding(.horizontal, 20)
//                    .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        // Remove the fixed frame constraints
        .sheet(isPresented: $showMoodView, onDismiss: {
            fetchMoods()
        }) {
            MoodView()
                .environmentObject(sessionController)
                .environmentObject(moodController)
        }
        .onAppear {
            fetchMoods()
        }
    }

    private func fetchMoods() {
        guard let userId = sessionController.currentUser?.userId else {
            print("No user logged in.")
            moods = []
            return
        }

        do {
            moods = try moodController.getMoods(for: userId)
        } catch {
            print("Failed to fetch moods: \(error.localizedDescription)")
        }
    }
}

// Helper for mood color
func colorForMood(_ mood: String) -> Color {
    switch mood.lowercased() {
    case "unhappy": return .red
    case "sad": return .blue
    case "normal": return .purple
    case "good": return .green
    case "happy": return .yellow
    default: return .gray
    }
}

#Preview {
    let session = SessionController()
    session.currentUser = UserModel(
        userId: 1, username: "Test", password: "123")

    let context = try! ModelContainer(for: MoodModel.self).mainContext
    let moodController = MoodController(context: context)

    return MoodLogView()
        .environmentObject(session)
        .environmentObject(moodController)
}
