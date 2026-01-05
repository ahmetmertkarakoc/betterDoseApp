import SwiftUI

class EnglishGameViewModel: ObservableObject {
    @Published var currentWord: Word?
    @Published var options: [String] = []
    @Published var showResult: Bool = false
    @Published var isCorrect: Bool = false
    
    private var allWords: [Word] = WordPack.beginner + WordPack.intermediate
    
    func startNewRound() {
        showResult = false
        isCorrect = false
        currentWord = allWords.randomElement()
        generateOptions()
    }
    
    func checkAnswer(_ answer: String) {
        guard let current = currentWord else { return }
        
        if answer == current.turkish {
            isCorrect = true
        } else {
            isCorrect = false
        }
        showResult = true
    }
    
    private func generateOptions() {
        guard let current = currentWord else { return }
        
        var ops = [current.turkish]
        while ops.count < 4 {
            if let randomWord = allWords.randomElement(), !ops.contains(randomWord.turkish) {
                ops.append(randomWord.turkish)
            }
        }
        options = ops.shuffled()
    }
}
