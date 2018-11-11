//
//  ViewController.swift
//  TODOApp
//
//  Created by Coy Woolard on 11/10/18.
//  Copyright © 2018 Coy Woolard. All rights reserved.
//

import UIKit

final class TodoListItemViewController: UIViewController {

    private struct LayoutAttributes {
        static let addButtonDimension: CGFloat = 60
    }

    // MARK: - Properties

    private let viewModel: TodoItemViewControllerModel

    // MARK: - Initialization

    init(_ viewModel: TodoItemViewControllerModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        title = viewModel.title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        view.addSubview(addButton)

        addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: LayoutAttributes.addButtonDimension).isActive = true
        addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor).isActive = true

        viewModel.todoItems.valueChanged = { [weak self] in
            self?.tableView.reloadData()
        }

        NotificationCenter.default.addObserver(self, selector: #selector(handleAddingTodoItem(notification:)), name: .didAddTodoItem, object: nil)
    }

    // MARK: - Actions

    @objc private func addTodoItem() {
        let addViewController = AddTodoItemViewController(viewModel.addTodoViewControllerModel())
        addViewController.modalPresentationStyle = .formSheet
        present(addViewController, animated: true)
    }

    @objc private func handleAddingTodoItem(notification: Notification) {
        viewModel.reloadTodoItems()
    }

    // MARK: - Views

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TodoItemTableViewCell.self, forCellReuseIdentifier: TodoItemTableViewCell.reuseIdentifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: view.safeAreaInsets.top, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
        
        return tableView
    }()

    private let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        button.setImage(#imageLiteral(resourceName: "add-icon.png").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .todoRed
        button.layer.cornerRadius = LayoutAttributes.addButtonDimension / 2
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(addTodoItem), for: .touchUpInside)

        return button
    }()

}

extension TodoListItemViewController: TodoItemDelegate {

    func didUpdateTodoItems() {
        tableView.reloadData()
    }
}

extension TodoListItemViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.todoItems.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoItemTableViewCell.reuseIdentifier, for: indexPath) as! TodoItemTableViewCell
        let item = viewModel.todoItems.value[indexPath.row]
        cell.viewModel = item
        return cell
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let item = viewModel.todoItems.value[indexPath.row]
        return [
            UITableViewRowAction(style: .destructive, title: viewModel.removeActionTitle, handler: { (action, indexPath) in
                let todoItem = self.viewModel.todoItems.value[indexPath.row].todoItem
                self.viewModel.remove(todoItem: todoItem)
            }),
            UITableViewRowAction(style: .normal, title: item.toggleCompleteDisplayValue, handler: { (action, indexPath) in
                self.viewModel.toggleCompletion(for: item.todoItem)
            })
        ]
    }
}

extension TodoListItemViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.todoItems.value[indexPath.row]
        viewModel.toggleCompletion(for: item.todoItem)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
