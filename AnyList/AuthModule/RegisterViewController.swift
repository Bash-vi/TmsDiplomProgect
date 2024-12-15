//
//  RegisterViewController.swift
//  AnyList
//
//  Created by Вячеслав Башур on 13/12/2024.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let viewService = ViewService.shared
    
    let indent = Config.Indent.self
    
    lazy var errorLabel = AppLabel(style: .error)
    
    lazy var titleLabel = AppLabel(style: .pagetitle)
    
    lazy var icon = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "list.bullet.rectangle")
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .white
        icon.layer.shadowColor = UIColor.black.cgColor
        icon.layer.shadowOffset = .init(width: 8, height: 8)
        icon.layer.shadowOpacity = 0.3
        icon.heightAnchor.constraint(equalToConstant: 180).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 180).isActive = true
        return icon
    }()
    
    lazy var emailField = AppTextField(placeholderText: "Введите вашу почту")
    
    lazy var passwordField = AppTextField(placeholderText: "Введите пароль")
    
    lazy var nameField = AppTextField(placeholderText: "Введите имя")
    
    lazy var surenameField = AppTextField(placeholderText: "Введите фамилию")
    
    lazy var closeButton = AppButton(style: .close, action: close)

    lazy var saveButton = AppButton(style: .save, action: save)
    
    lazy var stack = viewService.verticalStack(subviews: [
            titleLabel, emailField,
            passwordField, nameField,
            surenameField, saveButton,
            errorLabel
    ])

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        titleLabel.text = "Регистрация"
        view.addSubview(closeButton)
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: indent.left),
            
            stack.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: Config.spacing),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: indent.left),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: indent.right)
        ])
    }
    
    //MARK: Button action
    lazy var close: UIAction = .init(handler: { [weak self] _ in
        
    })
    
    lazy var save: UIAction = .init(handler: { [weak self] _ in
        
    })
}
