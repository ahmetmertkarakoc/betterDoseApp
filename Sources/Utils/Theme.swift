import SwiftUI

struct Theme {
    static let primary = Color("PrimaryBrand") // Define in Assets, or fallback
    static let background = Color("AppBackground")
    static let secondary = Color("SecondaryAccent")
    
    // Fallbacks if Assets not present
    static let fallbackPrimary = Color.blue
    static let fallbackBackground = Color.black
    static let fallbackSecondary = Color.purple
    
    static let pixelFont = "CourierNewPS-BoldMT" // A common monospaced font as placeholder for pixel font
}

extension Color {
    static let brandPrimary = Color(red: 0.4, green: 0.6, blue: 1.0)
    static let brandPurple = Color(red: 0.6, green: 0.4, blue: 1.0)
    static let brandSuccess = Color(red: 0.2, green: 0.8, blue: 0.4)
    static let brandDanger = Color(red: 1.0, green: 0.3, blue: 0.3)
    static let brandGold = Color(red: 1.0, green: 0.84, blue: 0.0)
}
