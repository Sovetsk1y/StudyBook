//
//  HintViewController.swift
//  StudyBook
//
//  Created by Евгений Сивицкий on 16/09/2019.
//  Copyright © 2019 Евгений Сивицкий. All rights reserved.
//

import UIKit

final class HintViewController: UIViewController {
    
    private struct Constants {
        static let noHintError = "НИКАКОГО ТЕКСТА НЕТ("
        static let dismissButtonHeight: CGFloat = 50
    }

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("Закрыть", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = Constants.dismissButtonHeight / 2.0
        button.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleDismissButton), for: .touchUpInside)
        return button
    }()
    
    var hint: Hint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        handleHint()
    }
    
    //MARK: - private funcs
    
    private func handleHint() {
        guard let hint = hint else { titleLabel.text = Constants.noHintError; return }
        titleLabel.text = hint.name.uppercased()
        textLabel.text = hint.text
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.white
        
        view.addSubview(dismissButton)
        view.addSubview(titleLabel)
        view.addSubview(separator)
        view.addSubview(textLabel)
        
        
        //Constraints for dismissButton
        dismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: Constants.dismissButtonHeight).isActive = true
        
        //Constraints for titleLabel
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16).isActive = true
        
        //Constraints for separator
        separator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        separator.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        separator.widthAnchor.constraint(equalToConstant: view.frame.width - 94).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        //Constraints for textLabel
        textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24).isActive = true
        textLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        textLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16).isActive = true
        
    }
    
    //MARK: - @objc funcs
    
    @objc private func handleDismissButton() {
        dismiss(animated: true, completion: nil)
    }

}
