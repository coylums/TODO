//
//  TodoItemListViewModel.swift
//  TODOApp
//
//  Created by Coy Woolard on 11/10/18.
//  Copyright © 2018 Coy Woolard. All rights reserved.
//

import UIKit

protocol TodoItemDelegate: class {
    func didUpdateTodoItems()
}

class TodoItemViewControllerModel {

    private let dataModelService: DataModelService
    private let listItem: ListItem

    var title: String {
        return listItem.title ?? ""
    }

    var todoItems = Observable([TodoItemViewModel]())

    // MARK: - Strings

    let removeActionTitle = "Remove"

    // MARK: - Initialization

    init(_ dataModelService: DataModelService, listItem: ListItem) {
        self.dataModelService = dataModelService
        self.listItem = listItem
        self.todoItems.value = listItem.todoItems.map { TodoItemViewModel($0) }
    }

    // MARK: - View Models

    func addTodoViewControllerModel() -> AddTodoViewControllerModel {
        return AddTodoViewControllerModel(dataModelService, listItem: listItem)
    }

    // MARK: - TodoItems

    func toggleCompletion(for todoItem: TodoItem) {
        dataModelService.toggleCompletion(for: todoItem)
        reloadTodoItems()
    }

    func remove(todoItem: TodoItem) {
        dataModelService.remove(todoItem)
        reloadTodoItems()
    }

    func reloadTodoItems() {
        todoItems.value = listItem.todoItems.map { TodoItemViewModel($0) }
    }
}
