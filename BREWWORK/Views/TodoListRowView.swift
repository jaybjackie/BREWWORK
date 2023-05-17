//
//  TodoListRowView.swift
//  BREWWORK
//
//  Created by Jay B on 14/5/2566 BE.
//

import SwiftUI

struct TodoListRowView: View {
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    let item: ItemModel
    
    @State var timeRemaining: String = ""
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.day, .hour, .minute], from: Date(), to: item.deadline)
        let day = remaining.day ?? 0
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        // Time remaining outputs
        if (day == 0 ) {
            timeRemaining = hour == 1 ? "\(hour) hour left" : "\(hour) hours left"
            if (hour <= 0){
                timeRemaining = minute == 1 ? "\(minute) minute left" : "\(minute) minutes left"
                if (minute <= 0) {
                    timeRemaining = "Less than a minute left"
                    if (second <= 0) {
                        timeRemaining = "Lated"
                    }
                }
            }
        } else { // >= 1 day left
            if (day == 1) {
                if (hour == 1) {
                    timeRemaining = "\(day) day, \(hour) hour left"
                }
                timeRemaining = "\(day) day, \(hour) hours left"
            } else{
                if (hour == 1){
                    timeRemaining = "\(day) days, \(hour) hour left"
                }
                timeRemaining = "\(day) days, \(hour) hours left"
            }
        }
    }

    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
            Text(item.title)
            VStack(alignment: .leading) {
                if (item.isHaveDeadline && !item.isCompleted) {
                    Text(timeRemaining)
                        .foregroundColor(item.deadline > Date() ? .black : .red)
                        .font(.system(size: 14, weight: .regular))
                }
            } // END : VSTACK
            Spacer()
        } // END : HSTACK
        .onReceive(timer, perform: { _ in 
            updateTimeRemaining()
        })
        .font(.title2)
        .padding(.vertical, 8)
    }
}

struct TodoListRowView_Previews:
    PreviewProvider {

    static var item1 = ItemModel(title: "Complete and Have deadline", isCompleted: false, isHaveDeadline: true, deadline: Date())
    static var item2 = ItemModel(title: "Nor complete", isCompleted: false, isHaveDeadline: false, deadline: Date())
    
    static var previews: some View {
        Group {
            TodoListRowView(item: item1)
            TodoListRowView(item: item2)
        }
        .previewLayout(.sizeThatFits)
    }
}
