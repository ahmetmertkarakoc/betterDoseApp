import SwiftUI

struct EnglishGameView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @StateObject private var gameViewModel = EnglishGameViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 30) {
            
            // Header
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                Spacer()
                Text("Word Challenge")
                    .font(.headline)
                Spacer()
                Image(systemName: "bolt.fill")
                    .foregroundColor(.yellow)
                Text("\(appViewModel.userProfile.character.currentXP)")
            }
            .padding()
            
            Spacer()
            
            if let word = gameViewModel.currentWord {
                VStack(spacing: 10) {
                    Text(word.english)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(Theme.primary)
                    
                    Text("/\(word.pronunciation)/")
                        .font(.subheadline)
                        .italic()
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 5)
                
                Spacer()
                
                // Options
                VStack(spacing: 15) {
                    ForEach(gameViewModel.options, id: \.self) { option in
                        Button(action: {
                            gameViewModel.checkAnswer(option)
                        }) {
                            Text(option)
                                .font(.title3)
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(borderColor(for: option), lineWidth: 2)
                                )
                        }
                        .disabled(gameViewModel.showResult)
                    }
                }
                .padding(.horizontal)
                
            } else {
                Text("Loading...")
            }
            
            Spacer()
            
            // Result Overlay / Next Button
            if gameViewModel.showResult {
                VStack {
                    if gameViewModel.isCorrect {
                        Text("Correct! 🎉")
                             .font(.title)
                             .foregroundColor(.green)
                             .bold()
                    } else {
                        Text("Wrong! It was \(gameViewModel.currentWord?.turkish ?? "")")
                             .font(.title3)
                             .foregroundColor(.red)
                    }
                    
                    Button("Next Word") {
                        if gameViewModel.isCorrect {
                            appViewModel.learnWord(wordId: gameViewModel.currentWord?.id ?? "")
                        }
                        gameViewModel.startNewRound()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Theme.primary)
                    .padding(.top)
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(20)
                .shadow(radius: 10)
                .transition(.scale)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .onAppear {
            gameViewModel.startNewRound()
        }
    }
    
    private func borderColor(for option: String) -> Color {
        if gameViewModel.showResult {
            if option == gameViewModel.currentWord?.turkish {
                return .green
            }
            if !gameViewModel.isCorrect && option != gameViewModel.currentWord?.turkish {
               // Highlight selected wrong answer? 
               // logic simplified here
               return .clear
            }
        }
        return .clear
    }
}
