import Foundation

class DataManager {
    static let shared = DataManager()
    private let userKey = "BetterDose_UserProfile"
    
    private init() {}
    
    func saveUserProfile(_ profile: UserProfile) {
        if let encoded = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(encoded, forKey: userKey)
        }
    }
    
    func loadUserProfile() -> UserProfile? {
        if let data = UserDefaults.standard.data(forKey: userKey),
           let profile = try? JSONDecoder().decode(UserProfile.self, from: data) {
            return profile
        }
        return nil
    }
    
    func clearData() {
        UserDefaults.standard.removeObject(forKey: userKey)
    }
}

struct UserProfile: Codable {
    var character: Character
    var habitState: UserHabitState
    var achievements: [Achievement]
    var learnedWords: [String] // IDs of learned words
    var isOnboardingComplete: Bool
    
    static func initial() -> UserProfile {
        return UserProfile(
            character: Character(name: "Player", level: 1, currentXP: 0, maxXP: 100, coins: 0, streak: 0),
            habitState: UserHabitState(habitsSelected: [], smokingData: nil, doomScrollingData: nil),
            achievements: [
                Achievement(id: "a1", title: "First Step", description: "Start your journey", isUnlocked: false, rewardXP: 50, rewardCoins: 10, iconName: "flag.fill"),
                Achievement(id: "a2", title: "24 Hours Clean", description: "Go 24 hours without smoking", isUnlocked: false, rewardXP: 100, rewardCoins: 50, iconName: "lungs.fill"),
                Achievement(id: "a3", title: "Vocab Master", description: "Learn 5 words", isUnlocked: false, rewardXP: 150, rewardCoins: 80, iconName: "book.fill")
            ],
            learnedWords: [],
            isOnboardingComplete: false
        )
    }
}
