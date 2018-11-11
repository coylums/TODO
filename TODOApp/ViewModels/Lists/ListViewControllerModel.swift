//
//  ListViewModel.swift
//  TODOApp
//
//  Created by Coy Woolard on 11/10/18.
//  Copyright © 2018 Coy Woolard. All rights reserved.
//

import Foundation

protocol ListItemDelegate: class {
    func didUpdateListItems()
}

class ListViewControllerModel {

    // MARK: - Properties

    private let dataModelService: DataModelService

    var listItems = Observable([ListItemViewModel]())

    // MARK: - Strings

    let title = "//TODO Lists"

    let emptyBarButtonTitle = ""

    let cancelActionTitle = "Cancel"
    let removeActionTitle = "Remove"

    let alertAddListActionTitle = "Create"
    let alertCreateNewListTitle = "Create a new list"

    // MARK: - Initialization

    init(_ dataModelService: DataModelService) {
        self.dataModelService = dataModelService
        self.listItems.value = dataModelService.fetchListItems().map { ListItemViewModel($0) }
    }

    // MARK: - View Models

    func todoItemViewControllerModel(for listItem: ListItem) -> TodoItemViewControllerModel {
        return TodoItemViewControllerModel(dataModelService, listItem: listItem)
    }

    // MARK: - Lists

    func createListItem(title: String) {
        dataModelService.createListItem(forTitle: title)
        reloadListItems()
    }

    func remove(listItem: ListItem) {
        dataModelService.remove(listItem)
        reloadListItems()
    }

    func reloadListItems() {
        listItems.value = dataModelService.fetchListItems().map { ListItemViewModel($0) }
    }
}
