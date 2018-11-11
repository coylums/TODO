//
//  ListViewController.swift
//  TODOApp
//
//  Created by Coy Woolard on 11/10/18.
//  Copyright © 2018 Coy Woolard. All rights reserved.
//

import Foundation

import UIKit

final class ListViewController: UIViewController {

    private struct LayoutAttributes {
        static let addButtonDimension: CGFloat = 60
    }

    // MARK: - Properties

    private let viewModel: ListViewControllerModel

    // MARK: - Initialization

    init(_ viewModel: ListViewControllerModel) {
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

        navigationController?.applytheme()

        navigationItem.backBarButtonItem = backBarButton

        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        view.addSubview(addButton)

        addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: LayoutAttributes.addButtonDimension).isActive = true
        addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor).isActive = true

        viewModel.listItems.valueChanged = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.reloadListItems()
    }

    // MARK: - Actions

    @objc private func showCreateListItemAlert() {

        let addAction = UIAlertAction(title: viewModel.alertAddListActionTitle, style: .default, handler: { _ in
            guard let title = self.addListItemTextField?.text else { return }
            self.addListItem(title: title)
            self.addListItemTextField = nil
        })
        addAction.isEnabled = false

        let alertController = UIAlertController(title: viewModel.alertCreateNewListTitle, message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.autocapitalizationType = .sentences
            self.addListItemTextField = textField
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: .main, using: { (_) in
                guard let text = textField.text else {
                    addAction.isEnabled = false
                    return
                }
                addAction.isEnabled = !text.isEmpty
            })
        }

        alertController.addAction(addAction)
        alertController.addAction(UIAlertAction(title: viewModel.cancelActionTitle, style: .default, handler: { _ in
            self.dismiss(animated: true)
        }))

        present(alertController, animated: true)
    }

    private func addListItem(title: String) {
        viewModel.createListItem(title: title)
    }

    // MARK: - Views

    private lazy var backBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: viewModel.emptyBarButtonTitle, style: .plain, target: nil, action: nil)
        button.tintColor = .white

        return button
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListItemTableViewCell.self, forCellReuseIdentifier: ListItemTableViewCell.reuseIdentifier)
        tableView.rowHeight = 60
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
        button.addTarget(self, action: #selector(showCreateListItemAlert), for: .touchUpInside)
        
        return button
    }()

    private var addListItemTextField: UITextField?
}

extension ListViewController: ListItemDelegate {

    func didUpdateListItems() {
        tableView.reloadData()
    }
}

extension ListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listItems.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListItemTableViewCell.reuseIdentifier, for: indexPath) as! ListItemTableViewCell
        let item = viewModel.listItems.value[indexPath.row]
        cell.viewModel = item
        return cell
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return [
            UITableViewRowAction(style: .destructive, title: viewModel.removeActionTitle, handler: { (action, indexPath) in
                let listItem = self.viewModel.listItems.value[indexPath.row].listItem
                self.viewModel.remove(listItem: listItem)
            })
        ]
    }
}

extension ListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listItem = self.viewModel.listItems.value[indexPath.row].listItem
        let viewController = TodoListItemViewController(viewModel.todoItemViewControllerModel(for: listItem))
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
