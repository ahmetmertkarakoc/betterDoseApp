import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        Form {
            Section(header: Text("Profile")) {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(viewModel.userProfile.character.name)
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Level")
                    Spacer()
                    Text("\(viewModel.userProfile.character.level)")
                }
            }
            
            Section(header: Text("Habits")) {
                if viewModel.userProfile.habitState.habitsSelected.contains(.smoking) {
                    NavigationLink("Smoking Settings") {
                        Text("Edit Smoking Details Here")
                    }
                }
                if viewModel.userProfile.habitState.habitsSelected.contains(.doomScrolling) {
                    NavigationLink("Doom Scroll Settings") {
                         Text("Edit Doom Scroll Details Here")
                    }
                }
            }
            
            Section {
                Button("Reset Progress (Dev Only)") {
                    DataManager.shared.clearData()
                    viewModel.userProfile = UserProfile.initial()
                }
                .foregroundColor(.red)
            }
        }
        .navigationTitle("Settings")
    }
}
