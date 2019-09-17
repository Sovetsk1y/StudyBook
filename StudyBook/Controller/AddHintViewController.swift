//
//  AddHintViewController.swift
//  StudyBook
//
//  Created by Евгений Сивицкий on 16/09/2019.
//  Copyright © 2019 Евгений Сивицкий. All rights reserved.
//

import UIKit

final class AddHintViewController: UIViewController {
    
    private struct Constants {
        static let hintNameLabelText = "Название подсказки"
        static let hintTextLabelText = "Текст подсказки"
        static let controllerTitleText = "Новая подсказка"
        static let buttonHeight: CGFloat = 50
        static let textFieldHeight: CGFloat = 50
        static let textViewHeight: CGFloat = 200
    }
    
    var subject: Subject!

    private var controllerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.text = Constants.controllerTitleText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var hintNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = Constants.hintNameLabelText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var hintTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = Constants.hintTextLabelText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var hintNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.placeholder = "Название подсказки"
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var hintTextTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private var dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("Закрыть", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = Constants.buttonHeight / 2.0
        button.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        button.addTarget(self, action: #selector(handleDismissButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Принять", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = Constants.buttonHeight / 2.0
        button.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        button.addTarget(self, action: #selector(handleConfirmButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    //MARK: - private funcs
    
    private func setupViews() {
        view.backgroundColor = UIColor.white
        
        view.addSubview(controllerTitleLabel)
        view.addSubview(hintNameLabel)
        view.addSubview(hintNameTextField)
        view.addSubview(hintTextLabel)
        view.addSubview(hintTextTextView)
        view.addSubview(dismissButton)
        view.addSubview(confirmButton)
        
        //Constraints for controllerTitleLabel
        controllerTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        controllerTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //Constraints for hintNameLabel
        hintNameLabel.topAnchor.constraint(equalTo: controllerTitleLabel.bottomAnchor, constant: 24).isActive = true
        hintNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        hintNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16).isActive = true
        
        //Constraints for hintNameTextField
        hintNameTextField.topAnchor.constraint(equalTo: hintNameLabel.bottomAnchor, constant: 8).isActive = true
        hintNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        hintNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        hintNameTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight).isActive = true
        hintNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //Constraints for hintTextLabel
        hintTextLabel.topAnchor.constraint(equalTo: hintNameTextField.bottomAnchor, constant: 16).isActive = true
        hintTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        hintTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16).isActive = true
        
        //Constraints for hintTextTextView
        hintTextTextView.topAnchor.constraint(equalTo: hintTextLabel.bottomAnchor, constant: 8).isActive = true
        hintTextTextView.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
        hintTextTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hintTextTextView.heightAnchor.constraint(equalToConstant: Constants.textViewHeight).isActive = true
        
        //Constraints for dismissButton
        dismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        dismissButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: (view.frame.width - 40) / 2).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
        
        //Constraints for confirmButton
        confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        confirmButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        confirmButton.widthAnchor.constraint(equalToConstant: (view.frame.width - 40) / 2).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
    }
    
    private func toggleHintNameError() {
        UIView.animate(withDuration: 1) {
            self.hintNameTextField.layer.borderWidth = 2
            self.hintNameTextField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    private func saveHint(_ hint: Hint) {
        guard Services.realmDatabase.saveHint(hint) == true else {
            self.showError(errorDescription: "Не удалось сохранить заметку")
            return
        }
    }
    
    //MARK: - @objc funcs
    
    @objc private func handleDismissButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleConfirmButton() {
        guard let hintName = hintNameTextField.text,
            !hintName.isEmpty else {
                toggleHintNameError()
                return
        }
        let hint = Hint()
        hint.name = hintName
        hint.text = hintTextTextView.text
        hint.subject = subject
        saveHint(hint)
        dismiss(animated: true, completion: nil)
    }

}
