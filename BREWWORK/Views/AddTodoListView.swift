//
//  AddTodoListView.swift
//  BREWWORK
//
//  Created by Jay B on 14/5/2566 BE.
//

import SwiftUI

struct AddTodoListView: View {
    // var for add an item
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    // var for Setting deadline
    @State var isHaveDeadline = false
    @State var deadline = Date()

    @State var timeRemaining: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type something here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                
                VStack {
                    Toggle(isOn: $isHaveDeadline) {
                        Text("Set the Deadline ⏰")
                    }
                    if (isHaveDeadline == true){
                        DatePicker("Deadline", selection: $deadline, in: Date()...)
                    }
                } // END : INNER VSTACK
                
                Button(action: {
                    saveButtonPressed()
                }, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            } // END : VSTACK
            .padding(14)
        } // END : SCROLLVIEW
        .navigationTitle("Add an Item 🖍️")
        .alert(isPresented: $showAlert, content: getAlert)
    } // END : BODY
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText, isHaveDeadline: isHaveDeadline, deadline: deadline)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "Your new todo item must be at least 3 characters long❗️"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct AddTodoListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AddTodoListView()
            }
            .preferredColorScheme(.light)
            .environmentObject(ListViewModel())
            NavigationView {
                AddTodoListView()
            }
            .preferredColorScheme(.dark)
            .environmentObject(ListViewModel())
        }
    }
}
