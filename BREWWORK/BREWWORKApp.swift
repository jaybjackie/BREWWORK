//
//  BREWWORKApp.swift
//  BREWWORK
//
//  Created by Jay B on 14/5/2566 BE.
//

import SwiftUI

@main
struct BREWWORKApp: App {
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TodoListView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel)
        }
    }
}
