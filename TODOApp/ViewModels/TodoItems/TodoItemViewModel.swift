//
//  TodoItemViewModel.swift
//  TODOApp
//
//  Created by Coy Woolard on 11/10/18.
//  Copyright © 2018 Coy Woolard. All rights reserved.
//

import UIKit

struct TodoItemViewModel {

    // MARK: - Properties

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()

    let todoItem: TodoItem

    let titleValue: String
    let noteValue: String
    let formattedDueDateValue: String

    let dateLabelColorValue: UIColor

    let isComplete: Bool
    let toggleCompleteDisplayValue: String

    // MARK: - Initialization

    init(_ todoItem: TodoItem) {

        self.todoItem = todoItem

        titleValue = todoItem.title ?? ""
        noteValue = todoItem.note ?? ""
        formattedDueDateValue = TodoItemViewModel.dateFormatter.string(from: todoItem.dueDate)
        dateLabelColorValue = todoItem.isDue ? .todoRed : .lightGray

        isComplete = todoItem.isComplete
        toggleCompleteDisplayValue = todoItem.isComplete ? "Incomplete" : "Complete"
    }
}
