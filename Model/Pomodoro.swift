//
//  Pomodoro.swift
//  StudyBuddy
//
//  Created by Jason Snider on 11/18/25.
//

enum Pomodoro: Int, CaseIterable {
    case work = 1800 // 30 min
    case shortBreak = 300 // 5 min
    case longBreak = 600 // 10 min
    
    var description: String {
        switch self {
            case .work = "Work"
            case .shortBreak = "Short Break"
            case .longBreak = "Long Break"
        }
    }
}
