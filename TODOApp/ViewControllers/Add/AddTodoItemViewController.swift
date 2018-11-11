//
//  AddTodoItemViewController.swift
//  TODOApp
//
//  Created by Coy Woolard on 11/10/18.
//  Copyright © 2018 Coy Woolard. All rights reserved.
//

import UIKit

final class AddTodoItemViewController: UIViewController {

    private struct LayoutAttributes {
        static let verticalPadding: CGFloat = 20
        static let horizontalPadding: CGFloat = 18
        static let closeButtonDimension: CGFloat = 36
        static let titleTextFieldHeightDimension: CGFloat = 40
        static let noteTextViewHeightDimension: CGFloat = 100
        static let submitButtonHeightDimension: CGFloat = 44
    }

    // MARK: - Properties

    private let viewModel: AddTodoViewControllerModel

    init(_ viewModel: AddTodoViewControllerModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(submitButton)
        view.addSubview(scrollView)

        scrollView.addSubview(titleTextLabel)
        scrollView.addSubview(titleTextField)
        scrollView.addSubview(noteTextLabel)
        scrollView.addSubview(noteTextView)
        scrollView.addSubview(todoDateLabel)
        scrollView.addSubview(datePicker)

        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -LayoutAttributes.verticalPadding).isActive = true

        view.addSubview(closeButton)

        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutAttributes.verticalPadding).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -LayoutAttributes.horizontalPadding).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: LayoutAttributes.closeButtonDimension).isActive = true
        closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor).isActive = true

        titleTextLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: LayoutAttributes.closeButtonDimension + LayoutAttributes.verticalPadding + 20).isActive = true
        titleTextLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: LayoutAttributes.horizontalPadding).isActive = true
        titleTextLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -LayoutAttributes.horizontalPadding).isActive = true

        titleTextField.topAnchor.constraint(equalTo: titleTextLabel.bottomAnchor, constant: LayoutAttributes.verticalPadding / 2).isActive = true
        titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: LayoutAttributes.horizontalPadding).isActive = true
        titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -LayoutAttributes.horizontalPadding).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: LayoutAttributes.titleTextFieldHeightDimension).isActive = true

        noteTextLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: LayoutAttributes.verticalPadding).isActive = true
        noteTextLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: LayoutAttributes.horizontalPadding).isActive = true
        noteTextLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -LayoutAttributes.horizontalPadding).isActive = true

        noteTextView.topAnchor.constraint(equalTo: noteTextLabel.bottomAnchor, constant: LayoutAttributes.verticalPadding / 2).isActive = true
        noteTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: LayoutAttributes.horizontalPadding).isActive = true
        noteTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -LayoutAttributes.horizontalPadding).isActive = true
        noteTextView.heightAnchor.constraint(equalToConstant: LayoutAttributes.noteTextViewHeightDimension).isActive = true

        todoDateLabel.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: LayoutAttributes.verticalPadding).isActive = true
        todoDateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: LayoutAttributes.horizontalPadding).isActive = true
        todoDateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -LayoutAttributes.horizontalPadding).isActive = true

        datePicker.topAnchor.constraint(equalTo: todoDateLabel.bottomAnchor, constant: LayoutAttributes.verticalPadding / 2).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: LayoutAttributes.horizontalPadding).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -LayoutAttributes.horizontalPadding).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -LayoutAttributes.verticalPadding).isActive = true

        submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -LayoutAttributes.verticalPadding).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: LayoutAttributes.horizontalPadding).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -LayoutAttributes.horizontalPadding).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: LayoutAttributes.submitButtonHeightDimension).isActive = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleTextField.becomeFirstResponder()
    }

    // MARK: - Actions

    @objc private func addTodoItem() {
        guard let title = titleTextField.text, !title.isEmpty else {
            presentAlert()
            return
        }
        viewModel.createTodoItem(title: title, note: noteTextView.text, dueDate: datePicker.date)
        dismiss(animated: true)
    }

    @objc private func close() {
        dismiss(animated: true)
    }

    private func presentAlert() {
        let alertController = UIAlertController(title: viewModel.alertTitle, message: viewModel.alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: viewModel.alertActionTitle, style: .default, handler: nil))
        present(alertController, animated: true)
    }

    // MARK: - Views

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: view.safeAreaInsets.top, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
        scrollView.alwaysBounceVertical = true
        
        return scrollView
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .todoLightGray
        button.setImage(#imageLiteral(resourceName: "close-icon").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(close), for: .touchUpInside)

        return button
    }()

    private lazy var titleTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .todoGray
        label.text = viewModel.addTitle
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)

        return label
    }()

    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .todoGrayBackground
        textField.layer.borderColor = UIColor.todoGray.withAlphaComponent(0.1).cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 6
        textField.clipsToBounds = true
        textField.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        textField.textColor = .black
        textField.delegate = self
        textField.returnKeyType = .done

        return textField
    }()

    private lazy var noteTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .todoGray
        label.text = viewModel.noteTextTitle
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)

        return label
    }()

    private lazy var noteTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .todoGrayBackground
        textView.layer.borderColor = UIColor.todoGray.withAlphaComponent(0.1).cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 6
        textView.clipsToBounds = true
        textView.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textView.textColor = .todoGray
        textView.delegate = self
        textView.returnKeyType = .done

        return textView
    }()

    private lazy var todoDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .todoGray
        label.text = viewModel.todoDateTitle
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)

        return label
    }()

    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .todoGrayBackground
        datePicker.layer.borderColor = UIColor.todoGray.withAlphaComponent(0.1).cgColor
        datePicker.layer.borderWidth = 1
        datePicker.layer.cornerRadius = 6
        datePicker.clipsToBounds = true

        return datePicker
    }()

    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(viewModel.saveButtonTitle, for: .normal)
        button.backgroundColor = .todoRed
        button.addTarget(self, action: #selector(addTodoItem), for: .touchUpInside)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true

        return button
    }()
}

extension AddTodoItemViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddTodoItemViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.rangeOfCharacter(from: CharacterSet.newlines) != nil {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
