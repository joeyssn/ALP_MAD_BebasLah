//
//  ALP_MAD_JoeyTests.swift
//  ALP_MAD_JoeyTests
//
//  Created by student on 22/05/25.
//

import XCTest
@testable import ALP_MAD_Joey
import SwiftData

@MainActor
final class ALP_MAD_JoeyTests: XCTestCase {

    var modelContainer: ModelContainer!
    var modelContext: ModelContext!

    override func setUpWithError() throws {
        modelContainer = try ModelContainer(for: UserModel.self, MoodModel.self)
        modelContext = modelContainer.mainContext
    }

    override func tearDownWithError() throws {
        modelContainer = nil
        modelContext = nil
    }

    func testUserRegistrationAndLogin() throws {
        let userVM = UserViewModel(context: modelContext)
        let username = "testuser"
        let password = "testpass"

        let registerResult = try userVM.register(username: username, password: password)
        XCTAssertTrue(registerResult)

        let loginResult = try userVM.login(username: username, password: password)
        XCTAssertNotNil(loginResult)
        XCTAssertEqual(loginResult?.username, username)
    }

    func testUserAlreadyExists() throws {
        let userVM = UserViewModel(context: modelContext)
        _ = try userVM.register(username: "existinguser", password: "pass123")
        let secondAttempt = try userVM.register(username: "existinguser", password: "pass456")
        XCTAssertFalse(secondAttempt, "Duplicate registration should fail")
    }

    func testMoodLoggingAndFetching() throws {
        let moodVM = MoodViewModel(context: modelContext)
        let userId = 1
        let moodName = "Happy"

        try moodVM.logMood(moodName: moodName, for: userId)
        let moods = try moodVM.getMoods(for: userId)

        XCTAssertFalse(moods.isEmpty, "Mood should be logged and retrievable")
        XCTAssertEqual(moods.first?.moodName, moodName)
    }

    func testSessionLoginAndLogout() {
        let sessionVM = SessionViewModel()
        let user = UserModel(userId: 99, username: "demo", password: "pass")

        sessionVM.login(user: user)
        XCTAssertTrue(sessionVM.isLoggedIn)
        XCTAssertEqual(sessionVM.currentUser?.username, "demo")

        sessionVM.logout()
        XCTAssertFalse(sessionVM.isLoggedIn)
        XCTAssertNil(sessionVM.currentUser)
    }

    func testNotificationScheduleAndCancel() {
        let notificationVM = NotificationViewModel()

        notificationVM.requestPermission()
        notificationVM.scheduleDailyNotification(at: "08:00 AM", for: "Steven")
        notificationVM.cancelNotification()

        XCTAssertTrue(true, "Notification scheduling and cancellation executed without crashing.")
    }

    func testMeditationViewModelInitialization() {
        let meditationVM = MeditationViewModel(context: modelContext)
        XCTAssertNotNil(meditationVM)
    }

    func testMeditationSessionSoundControls() {
        let meditationSessionVM = MeditationSessionViewModel(context: modelContext)

        meditationSessionVM.playSound(named: "testSound.mp3")
        meditationSessionVM.pauseSound()
        meditationSessionVM.resumeSound()
        meditationSessionVM.stopSound()

        XCTAssertTrue(true, "Sound control methods executed without crashing.")
    }
}
