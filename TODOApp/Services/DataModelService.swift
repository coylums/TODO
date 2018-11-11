//
//  DataModelService.swift
//  TODOApp
//
//  Created by Coy Woolard on 11/10/18.
//  Copyright © 2018 Coy Woolard. All rights reserved.
//

import Foundation
import RealmSwift

class DataModelService {

    private let realm: Realm

    init(_ realm: Realm = try! Realm()) {
        self.realm = realm
    }

    // MARK: - ListItems

    func createListItem(forTitle title: String) {
        try! realm.write {
            let listItem = ListItem(title: title)
            listItem.id = (realm.objects(ListItem.self).max(ofProperty: "id") ?? 0) + 1
            realm.add(listItem)
        }
    }

    func remove(_ listItem: ListItem) {
        try! realm.write {
            realm.delete(listItem)
        }
    }

    func fetchListItems() -> [ListItem] {
        let results = realm.objects(ListItem.self).sorted(byKeyPath: "id")
        return results.map { $0 }
    }

    // MARK: - TodoItems

    func appendTodoItem(to listItem: ListItem, title: String, note: String, dueDate: Date = Date()) {
        try! realm.write {
            let todoItem = TodoItem(title: title, note: note, dueDate: dueDate)
            todoItem.id = (realm.objects(TodoItem.self).max(ofProperty: "id") ?? 0) + 1
            listItem.todoItems.append(todoItem)
            realm.add(listItem, update: true)
        }
    }

    func toggleCompletion(for todoItem: TodoItem) {
        try! realm.write {
            todoItem.isComplete.toggle()
            realm.add(todoItem, update: true)
        }
    }

    func remove(_ todoItem: TodoItem) {
        try! realm.write {
            realm.delete(todoItem)
        }
    }

    func fetchTodoItems() -> [TodoItem] {
        let results = realm.objects(TodoItem.self).sorted(byKeyPath: "createdAt")
        return results.map { $0 }
    }
}
