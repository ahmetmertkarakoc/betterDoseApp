# BetterDose 🧠🎮

BetterDose is a gamified habit-breaking and self-improvement app.

## 🎯 Goal
Help users:
- Quit smoking 🚭
- Reduce social media scrolling 📵
- Improve vocabulary 📚
- Learn English naturally 🇬🇧

## 🕹 Core Concept
- Pixel-art RPG style
- Personalized 2D character
- Habits = XP & currency
- Progress = visual character evolution

## 🧩 Features (Planned)
- Habit tracking with rewards
- Mini word-learning games
- Daily challenges
- Offline-first logic
- Private build (not App Store)

## 🛠 Tech Stack (Planned)
- iOS: SwiftUI
- Backend: Self-hosted server
- Auth: Local / device-based
- Art: Pixel Art

## 🚀 Setup Instructions

1. **Create a New Xcode Project**:
   - Open Xcode > File > New > Project.
   - Choose **iOS App**.
   - Name it `BetterDose`.
   - Interface: **SwiftUI**.
   - Language: **Swift**.

2. **Import Files**:
   - Move the generated `Sources` folder contents into your new Xcode project folder (replace the default `ContentView.swift` and `BetterDoseApp.swift`).
   - Drag the `Models`, `Views`, `ViewModels`, `Services`, and `Utils` folders into the Xcode Project Navigator.
   - Ensure "Copy items if needed" is checked.

3. **Assets**:
   - The code uses system icons (SF Symbols) so it runs immediately.
   - For the full experience, add pixel art images to `Assets.xcassets` and update `GameModels.swift` and `CharacterView.swift` to use them.

## 🛠 Tech Stack
- **iOS**: SwiftUI (MVVM Architecture)
- **Persistence**: UserDefaults (Offline-first)
- **Gamification**: Custom GameEngine (XP, Levels, Inventory)

## 📁 Project Structure
- `Models/`: Data structures (Character, Habits, Words).
- `Views/`: SwiftUI Views (Dashboard, EnglishGame, etc.).
- `ViewModels/`: Business logic and state management.
- `Services/`: Game logic and persistence layers.
- `Utils/`: Constants and Theme configuration.

---
Built by ahmedovic & Antigravity