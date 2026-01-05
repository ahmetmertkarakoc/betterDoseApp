import SwiftUI

class AppViewModel: ObservableObject {
    @Published var userProfile: UserProfile
    var gameEngine = GameEngine()
    
    @Published var showCelebration: Bool = false
    @Published var celebrationMessage: String = ""
    
    init() {
        if let loaded = DataManager.shared.loadUserProfile() {
            self.userProfile = loaded
        } else {
            self.userProfile = UserProfile.initial()
        }
    }
    
    func save() {
        DataManager.shared.saveUserProfile(userProfile)
    }
    
    // MARK: - Onboarding
    func completeOnboarding(habits: [HabitType], cigPrice: Double, cigsPerDay: Int) {
        userProfile.habitState.habitsSelected = habits
        if habits.contains(.smoking) {
            userProfile.habitState.smokingData = SmokingData(lastCigaretteDate: Date(), cigarettesPerDay: cigsPerDay, packPrice: cigPrice)
        }
        if habits.contains(.doomScrolling) {
            userProfile.habitState.doomScrollingData = DoomScrollingData()
        }
        userProfile.isOnboardingComplete = true
        
        // Initial Reward
        _ = GameEngine.addXP(to: &userProfile.character, amount: 50)
        save()
    }
    
    // MARK: - Actions
    func registerSafeHabit(type: HabitType) {
        switch type {
        case .smoking:
            // Check if 24h passed? Or just manual 'Check-in'?
            // Usually smoking apps auto-calculate time.
            // Let's assume this is a "Milestone Reached" check or Daily Check-in
            let days = userProfile.habitState.smokingData?.daysClean ?? 0
            if days > 0 {
                // Reward based on days
                let rewardXP = 20 * days
                let leveledUp = GameEngine.addXP(to: &userProfile.character, amount: rewardXP)
                GameEngine.addCoins(to: &userProfile.character, amount: 5 * days)
                
                if leveledUp {
                   triggerCelebration(message: "Level Up! You are now lvl \(userProfile.character.level)")
                }
            }
            
        case .doomScrolling:
            // "Resisted Urge"
            if ((userProfile.habitState.doomScrollingData) != nil) {
                userProfile.habitState.doomScrollingData?.urgeResistCount += 1
                userProfile.habitState.doomScrollingData?.lastUrgeResistedDate = Date()
                
                let leveledUp = GameEngine.addXP(to: &userProfile.character, amount: 15)
                 GameEngine.addCoins(to: &userProfile.character, amount: 5)
                 
                 triggerCelebration(message: "Urge Resisted! +15 XP")
                 
                 if leveledUp {
                     triggerCelebration(message: "Level Up! You are now lvl \(userProfile.character.level)")
                 }
            }
        }
        
        // Universal Save
        save()
    }
    
    func resetSmokingDate() {
        userProfile.habitState.smokingData?.lastCigaretteDate = Date()
        userProfile.character.streak = 0
        save()
    }
    
    func learnWord(wordId: String) {
        if !userProfile.learnedWords.contains(wordId) {
            userProfile.learnedWords.append(wordId)
            let leveledUp = GameEngine.addXP(to: &userProfile.character, amount: 30)
            GameEngine.addCoins(to: &userProfile.character, amount: 10)
            
            triggerCelebration(message: "Word Learned! +30 XP")
            if leveledUp {
                 triggerCelebration(message: "Level Up! You are now lvl \(userProfile.character.level)")
            }
            
            // Check Achievements
            let newAchievements = GameEngine.checkAchievements(profile: &userProfile)
            for ach in newAchievements {
               // Show distinct achievement popup?
               // For now just console or queue
               print("Unlocked: \(ach.title)")
            }
            save()
        }
    }
    
    private func triggerCelebration(message: String) {
        self.celebrationMessage = message
        self.showCelebration = true
        
        // Auto hide after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showCelebration = false
        }
    }
}
