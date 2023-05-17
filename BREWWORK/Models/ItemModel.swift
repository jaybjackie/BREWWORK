//
//  ItemModel.swift
//  BREWWORK
//
//  Created by Jay B on 14/5/2566 BE.
//

import Foundation

struct ItemModel: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    let isHaveDeadline: Bool
    let deadline: Date
    
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool, isHaveDeadline: Bool, deadline: Date) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.isHaveDeadline = isHaveDeadline
        self.deadline = deadline
        
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted, isHaveDeadline: isHaveDeadline, deadline: deadline)
    }
}

