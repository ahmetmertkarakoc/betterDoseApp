import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header (Character Summary)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Hi, \(viewModel.userProfile.character.name)")
                            .font(.title2)
                            .bold()
                        Text("Level \(viewModel.userProfile.character.level) Warrior")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    // Small Avatar
                    Circle()
                        .fill(Theme.primary.opacity(0.2))
                        .frame(width: 50, height: 50)
                        .overlay(Image(systemName: "person.fill").foregroundColor(Theme.primary))
                }
                .padding(.horizontal)
                .padding(.top)
                
                // XP Progress
                VStack(alignment: .leading, spacing: 5) {
                    Text("XP \(viewModel.userProfile.character.currentXP) / \(viewModel.userProfile.character.maxXP)")
                        .font(.caption)
                        .bold()
                    
                    GeometryReader { geom in
                        ZStack(alignment: .leading) {
                            Capsule().fill(Color.gray.opacity(0.3))
                            Capsule()
                                .fill(LinearGradient(colors: [Theme.primary, Theme.secondary], startPoint: .leading, endPoint: .trailing))
                                .frame(width: geom.size.width * CGFloat(viewModel.userProfile.character.xpProgress()))
                        }
                    }
                    .frame(height: 12)
                }
                .padding(.horizontal)
                
                // Habits Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Your Battles")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal)
                    
                    if let smokingData = viewModel.userProfile.habitState.smokingData {
                        SmokingCard(data: smokingData, onCheckIn: {
                             viewModel.registerSafeHabit(type: .smoking)
                        })
                    }
                    
                    if let doomData = viewModel.userProfile.habitState.doomScrollingData {
                        DoomScrollingCard(data: doomData, onResist: {
                             viewModel.registerSafeHabit(type: .doomScrolling)
                        })
                    }
                }
                
                // Learning Section (Core Replacement)
                VStack(alignment: .leading) {
                    Text("Train Yourself")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal)
                    
                    NavigationLink(destination: EnglishGameView()) {
                        HStack {
                            Image(systemName: "book.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            VStack(alignment: .leading) {
                                Text("English Vocab Training")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("Replace urge with knowledge")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            Spacer()
                            Image(systemName: "play.circle.fill")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Theme.secondary)
                        .cornerRadius(15)
                        .padding(.horizontal)
                    }
                }
                
                Spacer()
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}

struct SmokingCard: View {
    let data: SmokingData
    let onCheckIn: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "lungs.fill")
                .foregroundColor(.red)
                .font(.largeTitle)
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text("Smoking Free")
                    .font(.headline)
                Text("\(data.daysClean) Days Clean")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Saved $\(String(format: "%.2f", data.moneySaved))")
                    .font(.caption)
                    .foregroundColor(.green)
            }
            Spacer()
            
            Button("Check In") {
                onCheckIn()
            }
            .buttonStyle(.borderedProminent)
            .tint(Theme.primary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

struct DoomScrollingCard: View {
    let data: DoomScrollingData
    let onResist: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "eye.slash.fill")
                .foregroundColor(.purple)
                .font(.largeTitle)
                .padding()
                .background(Color.purple.opacity(0.1))
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text("Doom Scrolling")
                    .font(.headline)
                Text("\(data.urgeResistCount) Urges Resisted")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            Button("I feel urge") {
                onResist()
            }
            .buttonStyle(.bordered)
            .tint(.purple)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}
