//
//  ListItemViewModel.swift
//  TODOApp
//
//  Created by Coy Woolard on 11/10/18.
//  Copyright © 2018 Coy Woolard. All rights reserved.
//

import UIKit

struct ListItemViewModel {

    // MARK: - Properties

    let listItem: ListItem

    let titleValue: String
    let countValue: String

    let todoCountBackgroundColor: UIColor

    // MARK: - Initialization

    init(_ listItem: ListItem) {

        self.listItem = listItem

        titleValue = listItem.title ?? ""
        countValue = "\(listItem.todoItems.count)"

        todoCountBackgroundColor = listItem.hasItemsDue ? .todoRed : .todoLightGray
    }
}
