//
//  RegisterViewController.swift
//  AnyList
//
//  Created by Вячеслав Башур on 13/12/2024.
//

import UIKit

class RegisterViewController: UIViewController, AuthViewProtocol {

    var presenter: AuthPresenterActionHandler?
    
    let viewService = ViewService.shared
    
    let indent = Config.Indent.self
    
    lazy var errorLabel = AppLabel(style: .error)
    
    lazy var titleLabel = AppLabel(style: .pagetitle)
    
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
    
    func present(errorText: String) {
        Task {
            errorLabel.text = errorText
        }
    }
    
    //MARK: Button action
    lazy var close: UIAction = .init(handler: { [weak self] _ in
        guard let self else { return }
        self.presenter?.closeRegisterView()
    })
    
    lazy var save: UIAction = .init(handler: { [weak self] _ in
        guard let self else { return }
        let email = emailField.text
        let password = passwordField.text
        let name = nameField.text
        let surename = surenameField.text
        let user: User = .init(email: email, password: password, name: name, surename: surename )
        Task { await self.presenter?.register(user: user) }
    })
}
