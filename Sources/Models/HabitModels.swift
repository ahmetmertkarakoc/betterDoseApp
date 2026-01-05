import Foundation

enum HabitType: String, Codable {
    case smoking
    case doomScrolling
}

struct SmokingData: Codable {
    var lastCigaretteDate: Date
    var cigarettesPerDay: Int
    var packPrice: Double
    var totalNotSmoked: Int = 0
    
    var daysClean: Int {
        let components = Calendar.current.dateComponents([.day], from: lastCigaretteDate, to: Date())
        return components.day ?? 0
    }
    
    var moneySaved: Double {
        // Simple logic: (PackPrice / 20) * cigarettesPerDay * daysClean
        let pricePerCig = packPrice / 20.0
        return pricePerCig * Double(cigarettesPerDay) * Double(daysClean)
    }
}

struct DoomScrollingData: Codable {
    var lastUrgeResistedDate: Date?
    var urgeResistCount: Int = 0
    var minutesSaved: Int = 0
}

struct UserHabitState: Codable {
    var habitsSelected: [HabitType]
    var smokingData: SmokingData?
    var doomScrollingData: DoomScrollingData?
}
