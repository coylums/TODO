//
//  TodoItem.swift
//  TODOApp
//
//  Created by Coy Woolard on 11/10/18.
//  Copyright © 2018 Coy Woolard. All rights reserved.
//

import Foundation
import RealmSwift

final class TodoItem: Object {

    // MARK: - Properties

    @objc dynamic var id: Int = 0
    @objc dynamic var title: String? = nil
    @objc dynamic var note: String? = nil
    @objc dynamic var createdAt: Date = Date()
    @objc dynamic var dueDate: Date = Date()
    @objc dynamic var isComplete: Bool = false

    override static func primaryKey() -> String? {
        return "id"
    }

    // MARK: - Initialization

    convenience init(title: String?, note: String?, dueDate: Date) {
        self.init()
        self.title = title
        self.note = note
        self.dueDate = dueDate
    }
}

extension TodoItem {

    var isDue: Bool {
        return Date().compare(dueDate) == .orderedDescending
    }
}
