//
//  AuthViewController.swift
//  AnyList
//
//  Created by Вячеслав Башур on 13/12/2024.
//

import UIKit

protocol AuthViewProtocol: AnyObject {
    func present(errorText: String)
}

class AuthViewController: UIViewController, AuthViewProtocol {
    
    var presenter: AuthPresenterActionHandler?
    
    let viewService = ViewService.shared
    
    let indent = Config.Indent.self
    
    lazy var anyListLabel = AppLabel(style: .anyList)
    
    lazy var errorLabel = AppLabel(style: .error)
    
    lazy var icon = AppIcon(style: .list)
    
    lazy var emailField = AppTextField(placeholderText: "Введите вашу почту")
    
    lazy var passwordField = AppTextField(placeholderText: "Введите пароль")
    
    lazy var loginInButton = AppButton(style: .loginIn, action: loginInButtonAction)

    lazy var registerButton = AppButton(style: .register, action: registerButtonAction)
    
    lazy var stack = viewService.verticalStack(subviews: [
        anyListLabel, icon,
        errorLabel, emailField,
        passwordField, loginInButton,
        registerButton
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = "что-то пошло не так"
        view.backgroundColor = .gray
        view.addSubview(anyListLabel)
        view.addSubview(stack)
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: indent.left),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: indent.right),
            
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func present(errorText: String) {
        Task {
            errorLabel.text = errorText
        }
    }
    
    //MARK: Button action
    lazy var loginInButtonAction: UIAction = .init(handler: { [weak self] _ in
        guard let self else { return }
        let email = emailField.text
        let password = passwordField.text
        Task { await self.presenter?.sighIn(email: email, password: password) }
    })
    
    lazy var registerButtonAction: UIAction = .init(handler: { [weak self] _ in
        guard let self else { return }
        self.presenter?.openRegisterView()
    })
}
