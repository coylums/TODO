//
//  TodoListTableViewCell.swift
//  TODOApp
//
//  Created by Coy Woolard on 11/10/18.
//  Copyright © 2018 Coy Woolard. All rights reserved.
//

import UIKit

final class TodoItemTableViewCell: UITableViewCell {

    static let reuseIdentifier = String(describing: TodoItemTableViewCell.self)

    private struct LayoutAttributes {
        static let verticalPadding: CGFloat = 16
        static let halfVerticalPadding = verticalPadding / 2
        static let horizontalPadding: CGFloat = 12
        static let completionButtonDimension: CGFloat = 30
    }

    // MARK: - Properties

    var viewModel: TodoItemViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            completedbutton.isSelected = viewModel.isComplete
            titleLabel.text = viewModel.titleValue
            noteLabel.text = viewModel.noteValue
            dueDateLabel.text = viewModel.formattedDueDateValue
            dueDateLabel.textColor = viewModel.dateLabelColorValue
        }
    }

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        contentView.addSubview(completedbutton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(noteLabel)
        contentView.addSubview(dueDateLabel)

        completedbutton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutAttributes.horizontalPadding).isActive = true
        completedbutton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        completedbutton.widthAnchor.constraint(equalToConstant: LayoutAttributes.completionButtonDimension).isActive = true
        completedbutton.heightAnchor.constraint(equalTo: completedbutton.widthAnchor).isActive = true

        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutAttributes.verticalPadding).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: completedbutton.trailingAnchor, constant: LayoutAttributes.horizontalPadding).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: dueDateLabel.leadingAnchor, constant: -LayoutAttributes.horizontalPadding).isActive = true

        noteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutAttributes.halfVerticalPadding).isActive = true
        noteLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        noteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutAttributes.horizontalPadding).isActive = true
        noteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutAttributes.verticalPadding).isActive = true

        dueDateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutAttributes.verticalPadding).isActive = true
        dueDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutAttributes.horizontalPadding).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()

        completedbutton.isSelected = false

        titleLabel.text = nil
        noteLabel.text = nil
        dueDateLabel.text = nil
        dueDateLabel.textColor = .todoGray
    }

    // MARK: - Views

    private lazy var completedbutton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "circle").withRenderingMode(.alwaysTemplate), for: .normal)
        button.setImage(#imageLiteral(resourceName: "filled-circle").withRenderingMode(.alwaysTemplate), for: .selected)
        button.tintColor = .todoRed
        button.isUserInteractionEnabled = false

        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let noteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textColor = .todoGray

        return label
    }()

    private let dueDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .todoGray

        return label
    }()

}
