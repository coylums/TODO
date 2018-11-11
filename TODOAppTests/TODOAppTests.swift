//
//  TODOAppTests.swift
//  TODOAppTests
//
//  Created by Coy Woolard on 11/10/18.
//  Copyright © 2018 Coy Woolard. All rights reserved.
//

import XCTest
import RealmSwift
@testable import TODOApp

class TODOAppTests: XCTestCase {

    let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "InMemoryRealm"))

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTodoItemCreationAndRemoval() {

        let dataModelService = DataModelService(realm)

        XCTAssert(dataModelService.fetchListItems().isEmpty)
        XCTAssert(dataModelService.fetchTodoItems().isEmpty)

        let listItem = ListItem(title: "Test List")

        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let lastWeek = Calendar.current.date(byAdding: .weekday, value: -1, to: Date())!

        dataModelService.appendTodoItem(to: listItem, title: "TODO 1", note: "A description", dueDate: Date())
        dataModelService.appendTodoItem(to: listItem, title: "TODO 2", note: "A description", dueDate: tomorrow)
        dataModelService.appendTodoItem(to: listItem, title: "TODO 3", note: "A description", dueDate: yesterday)
        dataModelService.appendTodoItem(to: listItem, title: "TODO 4", note: "A description", dueDate: lastWeek)

        XCTAssert(listItem.todoItems.count == 4)

        let todoItem1 = listItem.todoItems.last!
        dataModelService.remove(todoItem1)
        XCTAssert(dataModelService.fetchTodoItems().count == 3)

        let todoItem2 = listItem.todoItems.last!
        dataModelService.remove(todoItem2)
        XCTAssert(dataModelService.fetchTodoItems().count == 2)

        let todoItem3 = listItem.todoItems.last!
        dataModelService.remove(todoItem3)
        XCTAssert(dataModelService.fetchTodoItems().count == 1)

        let todoItem4 = listItem.todoItems.last!
        dataModelService.remove(todoItem4)

        XCTAssert(dataModelService.fetchTodoItems().isEmpty)

    }

    func testTodoItemViewModelCreation() {

        let dataModelService = DataModelService(realm)

        XCTAssert(dataModelService.fetchTodoItems().isEmpty)

        let todoItem1 = TodoItem(title: "TODO 1", note: "Awesome description 1", dueDate: Date())
        let viewModel1 = TodoItemViewModel(todoItem1)

        XCTAssertEqual(viewModel1.titleValue, "TODO 1")
        XCTAssertEqual(viewModel1.noteValue, "Awesome description 1")
        XCTAssertEqual(viewModel1.formattedDueDateValue, "Today")
        XCTAssertEqual(viewModel1.isComplete, false)
        XCTAssertEqual(viewModel1.toggleCompleteDisplayValue, "Complete")

        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        let todoItem2 = TodoItem(title: "TODO 2", note: "Awesome description 2", dueDate: tomorrow)
        let viewModel2 = TodoItemViewModel(todoItem2)

        XCTAssertEqual(viewModel2.titleValue, "TODO 2")
        XCTAssertEqual(viewModel2.noteValue, "Awesome description 2")
        XCTAssertEqual(viewModel2.formattedDueDateValue, "Tomorrow")
        XCTAssertEqual(viewModel2.isComplete, false)
        XCTAssertEqual(viewModel2.toggleCompleteDisplayValue, "Complete")

        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let todoItem3 = TodoItem(title: "TODO 3", note: "Awesome description 3", dueDate: yesterday)
        let viewModel3 = TodoItemViewModel(todoItem3)

        XCTAssertEqual(viewModel3.titleValue, "TODO 3")
        XCTAssertEqual(viewModel3.noteValue, "Awesome description 3")
        XCTAssertEqual(viewModel3.formattedDueDateValue, "Yesterday")
        XCTAssertEqual(viewModel3.isComplete, false)
        XCTAssertEqual(viewModel3.toggleCompleteDisplayValue, "Complete")

        let dayInPast = DateComponents(calendar: Calendar.current, year: 2018, month: 11, day: 3).date!
        let todoItem4 = TodoItem(title: "TODO 4", note: "Awesome description 4", dueDate: dayInPast)
        let viewModel4 = TodoItemViewModel(todoItem4)

        XCTAssertEqual(viewModel4.titleValue, "TODO 4")
        XCTAssertEqual(viewModel4.noteValue, "Awesome description 4")
        XCTAssertEqual(viewModel4.formattedDueDateValue, "11/3/18")
        XCTAssertEqual(viewModel4.isComplete, false)
        XCTAssertEqual(viewModel4.toggleCompleteDisplayValue, "Complete")
    }
}
