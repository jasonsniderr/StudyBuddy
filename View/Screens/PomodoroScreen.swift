//
//  PomodoroScreen.swift
//  StudyBuddy
//
//  Created by Jason Snider on 11/17/25.
//

import SwiftUI

struct PomodoroScreen: View {
    
    @State private var viewModel = PomodoroVM()
    
    var body: some View {
        VStack {
            timer
            controls
        }
        .padding()
    }
    
    private var timer: some View {
        Gauge(
            value: Double(viewModel.secondsRemaining),
            in: 0...Double(viewModel.mode.rawValue),
            label: {},
            currentValueLabel: {
                Text(viewModel.minutesAndSeconds)
            }
        )
    }
            private var controls: some View {
                Picker("Mode", selection: $viewModel.mode) {
                    ForEach(Pomodoro.allCases, id: \.self) { mode in
                        Text(mode.description)
                    }
                }
                .pickerStyle(.segmented)
                
                Button("Start", action: viewModel.start)
            }
        }


#Preview {
    PomodoroScreen()
}
