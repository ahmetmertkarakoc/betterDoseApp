import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var step = 0
    
    // Form States
    @State private var selectedHabits: Set<HabitType> = []
    @State private var cigPrice: String = ""
    @State private var cigsPerDay: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            if step == 0 {
                // Step 1: Welcome
                VStack(spacing: 20) {
                    Image(systemName: "heart.text.square.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Theme.primary)
                    
                    Text("Welcome to BetterDose")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Theme.primary)
                    
                    Text("Turn your bad habits into an epic RPG journey.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    Button("Start Journey") {
                        withAnimation { step += 1 }
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }
            } else if step == 1 {
                // Step 2: Choose Habits
                VStack(spacing: 20) {
                    Text("What do you want to conquer?")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 20) {
                        HabitSelectionCard(title: "Smoking", icon: "flame.fill", isSelected: selectedHabits.contains(.smoking)) {
                            if selectedHabits.contains(.smoking) {
                                selectedHabits.remove(.smoking)
                            } else {
                                selectedHabits.insert(.smoking)
                            }
                        }
                        
                        HabitSelectionCard(title: "Doom Scrolling", icon: "iphone.radiowaves.left.and.right", isSelected: selectedHabits.contains(.doomScrolling)) {
                            if selectedHabits.contains(.doomScrolling) {
                                selectedHabits.remove(.doomScrolling)
                            } else {
                                selectedHabits.insert(.doomScrolling)
                            }
                        }
                    }
                    
                    Button("Next") {
                        if !selectedHabits.isEmpty {
                            withAnimation {
                                if selectedHabits.contains(.smoking) {
                                    step = 2 // Go to smoking details
                                } else {
                                    finishOnboarding()
                                }
                            }
                        }
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .disabled(selectedHabits.isEmpty)
                }
            } else if step == 2 {
                // Step 3: Smoking Details
                VStack(spacing: 20) {
                    Text("Smoking Details")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    TextField("Pack Price (e.g. 50.0)", text: $cigPrice)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    TextField("Cigarettes per Day", text: $cigsPerDay)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button("Finish") {
                        finishOnboarding()
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .disabled(cigPrice.isEmpty || cigsPerDay.isEmpty)
                }
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func finishOnboarding() {
        let price = Double(cigPrice) ?? 0.0
        let count = Int(cigsPerDay) ?? 0
        viewModel.completeOnboarding(habits: Array(selectedHabits), cigPrice: price, cigsPerDay: count)
    }
}

struct HabitSelectionCard: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .font(.largeTitle)
                    .foregroundColor(isSelected ? .white : Theme.primary)
                Text(title)
                    .fontWeight(.medium)
                    .foregroundColor(isSelected ? .white : .primary)
            }
            .frame(width: 140, height: 140)
            .background(isSelected ? Theme.primary : Color.gray.opacity(0.1))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Theme.primary, lineWidth: 2)
            )
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 200)
            .background(Theme.primary)
            .foregroundColor(.white)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
