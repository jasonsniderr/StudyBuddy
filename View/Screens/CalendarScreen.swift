//
//  CalendarScreen.swift
//  StudyBuddy
//
//  Created by Jason Snider on 11/17/25.
//

import SwiftUI

struct CalendarScreen: View {
    
    @State private var date = Date()
    let myTasks: [String] = [ ]
    
    var body: some View {
        VStack {
            calendar
            taskList
        }
    }
    
    private var calendar: some View {
        DatePicker("Date", selection: $date, displayedComponents: .date)
            .datePickerStyle(.graphical)
    }
    
    @ViewBuilder
    private var taskList: some View {
        if myTasks.isEmpty {
            ContentUnavailableView("No Tasks", systemImage: "tray.fill")
                .background(Color(UIColor.systemGroupedBackground))
        } else {
            List {
                ForEach(myTasks, id: \.self) { task in
                    Text(task)
                }
            }
        }
    }
}


#Preview {
    CalendarScreen()
}
