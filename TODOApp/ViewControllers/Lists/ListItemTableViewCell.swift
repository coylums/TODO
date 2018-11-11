//
//  TodoListTableViewCell.swift
//  TODOApp
//
//  Created by Coy Woolard on 11/10/18.
//  Copyright © 2018 Coy Woolard. All rights reserved.
//

import UIKit

final class ListItemTableViewCell: UITableViewCell {

    static let reuseIdentifier = String(describing: ListItemTableViewCell.self)

    private struct LayoutAttributes {
        static let verticalPadding: CGFloat = 16
        static let halfVerticalPadding = verticalPadding / 2
        static let horizontalPadding: CGFloat = 16
        static let labelWrapperHeight: CGFloat = 24
    }

    // MARK: - Properties

    var viewModel: ListItemViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.titleValue
            todoCountLabel.text = viewModel.countValue
            labelWrapperView.backgroundColor = viewModel.todoCountBackgroundColor
        }
    }

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        accessoryType = .disclosureIndicator

        contentView.addSubview(titleLabel)
        contentView.addSubview(labelWrapperView)
        labelWrapperView.addSubview(todoCountLabel)

        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutAttributes.horizontalPadding).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: todoCountLabel.leadingAnchor, constant: -LayoutAttributes.horizontalPadding).isActive = true

        labelWrapperView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        labelWrapperView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutAttributes.horizontalPadding).isActive = true
        labelWrapperView.heightAnchor.constraint(equalToConstant: LayoutAttributes.labelWrapperHeight).isActive = true

        todoCountLabel.centerYAnchor.constraint(equalTo: labelWrapperView.centerYAnchor).isActive = true
        todoCountLabel.leadingAnchor.constraint(equalTo: labelWrapperView.leadingAnchor, constant: 12).isActive = true
        todoCountLabel.trailingAnchor.constraint(equalTo: labelWrapperView.trailingAnchor, constant: -12).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel.text = nil
        todoCountLabel.text = nil
    }

    // MARK: - Views

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let todoCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        label.textColor = .white

        return label
    }()

    private let labelWrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .todoRed
        view.layer.cornerRadius = LayoutAttributes.labelWrapperHeight / 2
        view.clipsToBounds = true

        return view
    }()

}
