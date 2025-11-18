//
//  PomodoroVM.swift
//  StudyBuddy
//
//  Created by Jason Snider on 11/18/25.
//

import Foundation
import Observation

@Observable
class PomodoroVM {
    var mode = Pomodoro.work {
        didSet { secondsRemaining = mode.rawValue }
    }
    private(set) var secondsRemaining = Pomodoro.work.rawValue
    var minutesAndSeconds: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: TimeInterval(secondsRemaining)) ?? "00:00"
    }
    
    private var timer: Timer?
    private var isRunning: Bool {
        timer != nil
    }
    
    func start() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.secondsRemaining -= 1
            if self.secondsRemaining <= 0 {
                self.stop()
            }
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        secondsRemaining = mode.rawValue
    }
}
