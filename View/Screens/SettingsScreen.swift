//
//  SettingsScreen.swift
//  StudyBuddy
//
//  Created by Jason Snider on 11/17/25.
//

import SwiftUI

struct SettingsScreen: View {
    
    @Binding var accentColor: Color
    
    var body: some View {
        Form {
            ColorPicker("Accent Color:", selection: $accentColor)
        }
    }
}

