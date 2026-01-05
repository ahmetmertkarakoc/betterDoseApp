import Foundation

class GameEngine {
    
    // Returns true if leveled up
    static func addXP(to character: inout Character, amount: Int) -> Bool {
        character.currentXP += amount
        if character.currentXP >= character.maxXP {
            levelUp(character: &character)
            return true // Leveled up
        }
        return false // No level up
    }
    
    static func levelUp(character: inout Character) {
        character.currentXP = character.currentXP - character.maxXP // Carry over overflow
        character.level += 1
        character.maxXP = Int(Double(character.maxXP) * 1.5) // Increase difficulty
        character.coins += 50 // Level up bonus
    }
    
    static func addCoins(to character: inout Character, amount: Int) {
        character.coins += amount
    }
    
    static func updateStreak(character: inout Character, isSuccess: Bool) {
        if isSuccess {
            character.streak += 1
        } else {
            character.streak = 0
            // Logic: Maybe don't reset to 0 completely if we want to be kind?
            // "Bad habits DO NOT punish harshly." - The prompt says.
            // Maybe just -1 or keep XP. But streak usually resets.
            // Let's reset streak but NOT remove XP or Coins.
        }
    }
    
    // Returns newly unlocked achievements
    static func checkAchievements(profile: inout UserProfile) -> [Achievement] {
        var unlocked: [Achievement] = []
        
        // Example check: First Step
        if !profile.isOnboardingComplete { 
             // Logic handled elsewhere usually, but let's check basic stats
        }
        
        for index in 0..<profile.achievements.count {
            if !profile.achievements[index].isUnlocked {
                let id = profile.achievements[index].id
                
                // Achievement Logic
                if id == "a2" && (profile.habitState.smokingData?.daysClean ?? 0) >= 1 {
                    profile.achievements[index].isUnlocked = true
                    unlocked.append(profile.achievements[index])
                }
                
                if id == "a3" && profile.learnedWords.count >= 5 {
                    profile.achievements[index].isUnlocked = true
                    unlocked.append(profile.achievements[index])
                }
            }
        }
        
        return unlocked
    }
}
