import Foundation

struct Character: Codable, Identifiable {
    var id = UUID()
    var name: String
    var level: Int = 1
    var currentXP: Int = 0
    var maxXP: Int = 100
    var coins: Int = 0
    var streak: Int = 0
    
    // Equipment IDs
    var hatId: String?
    var outfitId: String?
    var accessoryId: String?
    
    var inventory: [String] = [] // IDs of owned items
    
    func xpProgress() -> Double {
        return Double(currentXP) / Double(maxXP)
    }
}

struct Item: Identifiable, Codable {
    var id: String
    var name: String
    var type: ItemType
    var price: Int
    var rarity: Rarity
    var assetName: String
}

enum ItemType: String, Codable {
    case hat
    case outfit
    case accessory
}

enum Rarity: String, Codable {
    case common
    case rare
    case epic
    case legendary
    
    var color: String {
        switch self {
        case .common: return "gray"
        case .rare: return "blue"
        case .epic: return "purple"
        case .legendary: return "gold"
        }
    }
}

struct Achievement: Identifiable, Codable {
    var id: String
    var title: String
    var description: String
    var isUnlocked: Bool
    var rewardXP: Int
    var rewardCoins: Int
    var iconName: String
}
