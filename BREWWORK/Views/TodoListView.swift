//
//  TodoListView.swift
//  BREWWORK
//
//  Created by Jay B on 14/5/2566 BE.
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List {
                    ForEach(listViewModel.items) { item in
                        TodoListRowView(item: item)

                            .onTapGesture {
                                withAnimation(.linear){
                                    listViewModel.updateItem(item: item)
                                }
                            }            }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                } // END : LIST
                .listStyle(.plain)
            }
        } // END : ZSTACK
        .navigationTitle("Todo List 📝")
        .navigationBarItems(leading: EditButton()
                            , trailing:
                                NavigationLink ("Add", destination: AddTodoListView())
        )
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TodoListView()
        }
        .environmentObject(ListViewModel())
    }
}
