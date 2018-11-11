//
//  AddTodoViewControllerModel.swift
//  TODOApp
//
//  Created by Coy Woolard on 11/10/18.
//  Copyright © 2018 Coy Woolard. All rights reserved.
//

import Foundation

struct AddTodoViewControllerModel {

    // MARK: - Properties

    private let dataModelService: DataModelService
    private let listItem: ListItem

    // MARK: - Strings

    let addTitle = "TODO Title"
    let saveButtonTitle = "Save"
    let noteTextTitle = "Add a short description..."
    let todoDateTitle = "Due Date"

    let alertTitle = "Forget something?"
    let alertMessage = "Please enter a title for your TODO..."
    let alertActionTitle = "Ok"

    // MARK: - Initialization

    init(_ dataModelService: DataModelService, listItem: ListItem) {
        self.dataModelService = dataModelService
        self.listItem = listItem
    }

    // MARK: TodoItems

    func createTodoItem(title: String, note: String?, dueDate: Date = Date()){
        let title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let note = note?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        dataModelService.appendTodoItem(to: listItem, title: title, note: note, dueDate: dueDate)
        NotificationCenter.default.post(name: .didAddTodoItem, object: nil)
    }
}
