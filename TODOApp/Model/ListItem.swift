//
//  ListItem.swift
//  TODOApp
//
//  Created by Coy Woolard on 11/10/18.
//  Copyright © 2018 Coy Woolard. All rights reserved.
//

import Foundation
import RealmSwift

final class ListItem: Object {

    // MARK: - Properties

    @objc dynamic var id: Int = 0
    @objc dynamic var title: String? = nil
    let todoItems = List<TodoItem>()

    override static func primaryKey() -> String? {
        return "id"
    }

    // MARK: - Initialization

    convenience init(title: String) {
        self.init()
        self.title = title
    }
}

extension ListItem {

    var hasItemsDue: Bool {
        return !todoItems.filter { $0.isDue }.isEmpty
    }
}
