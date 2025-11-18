//
//  BottomNavigation.swift
//  StudyBuddy
//
//  Created by Jason Snider on 11/17/25.
//

import SwiftUI

struct BottomNavigation: View {
    
    @State private var showSettings = false
    @AppStorage("accent_color") private var accentColor = Color.Hex.random
//    @State private var accentColor = Color.blue
    
    var body: some View {
        TabView {
            Tab("Calendar", systemImage: "calendar") {
                NavigationStack {
                    CalendarScreen()
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button("Settings", systemImage: "gear") {
                                    showSettings = true
                            }
                        }
                    }
                }
            }
                Tab("Pomodoro", systemImage: "timer") {
                    PomodoroScreen()
                }
            }
        .tint(Color(hex: accentColor))
        .sheet(isPresented: $showSettings) {
            SettingsScreen(accentColor: $accentColor.asColorBinding())
        }
    }
}

#Preview {
    BottomNavigation()
}
