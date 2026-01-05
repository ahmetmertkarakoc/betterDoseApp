import SwiftUI

struct CharacterView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Your Avatar")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                // Avatar Display
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 250, height: 300)
                    
                    // Layered Pixel Art Placeholders (Simulated)
                    // In real app, these are Image("Asset")
                    VStack {
                         Image(systemName: "person.fill")
                             .resizable()
                             .scaledToFit()
                             .frame(width: 100)
                             .foregroundColor(.gray)
                        
                        Text("Pixel Character Here")
                            .font(.custom(Theme.pixelFont, size: 14))
                            .opacity(0.6)
                    }
                    
                    // Equipment Overlays
                    if viewModel.userProfile.character.hatId != nil {
                        Image(systemName: "hat.wide.fill")
                             .resizable()
                             .frame(width: 60, height: 40)
                             .position(x: 125, y: 80) // Approximated
                             .foregroundColor(.orange)
                    }
                }
                
                // Stats Grid
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    StatBox(title: "Level", value: "\(viewModel.userProfile.character.level)", icon: "crown.fill", color: .yellow)
                    StatBox(title: "Coins", value: "\(viewModel.userProfile.character.coins)", icon: "centsign.circle.fill", color: .orange)
                    StatBox(title: "Streak", value: "\(viewModel.userProfile.character.streak)", icon: "flame.fill", color: .red)
                    StatBox(title: "XP", value: "\(viewModel.userProfile.character.currentXP)", icon: "bolt.fill", color: .blue)
                }
                .padding(.horizontal)
                
                // Shop / Inventory Link
                VStack(alignment: .leading) {
                    Text("Inventory")
                         .font(.headline)
                         .padding(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<5) { _ in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 60, height: 60)
                                    .overlay(Image(systemName: "lock.fill").foregroundColor(.gray))
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct StatBox: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
            Text(value)
                .font(.title2)
                .bold()
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.05), radius: 5)
    }
}
