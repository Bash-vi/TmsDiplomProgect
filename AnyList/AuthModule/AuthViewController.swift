//
//  AuthViewController.swift
//  AnyList
//
//  Created by Вячеслав Башур on 13/12/2024.
//

import UIKit

class AuthViewController: UIViewController {
    
    let viewService = ViewService.shared
    
    let indent = Config.Indent.self
    
    lazy var anyListLabel = AppLabel(style: .anyList)
    
    lazy var errorLabel = AppLabel(style: .error)
    
    lazy var icon = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "list.bullet.rectangle")
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .white
        icon.layer.shadowColor = UIColor.black.cgColor
        icon.layer.shadowOffset = .init(width: 8, height: 8)
        icon.layer.shadowOpacity = 0.3
        icon.heightAnchor.constraint(equalToConstant: Config.listIconSize).isActive = true
        icon.widthAnchor.constraint(equalToConstant: Config.listIconSize).isActive = true
        return icon
    }()
    
    lazy var emailField = AppTextField(placeholderText: "Введите вашу почту")
    
    lazy var passwordField = AppTextField(placeholderText: "Введите пароль")
    
    lazy var loginInButton = AppButton(style: .loginIn, action: loginInAction)

    lazy var registerButton = AppButton(style: .register, action: registerAction)
    
    lazy var stack = viewService.verticalStack(subviews: [
        anyListLabel, icon, errorLabel, emailField, passwordField, loginInButton, UIView() ,registerButton
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
    
    //MARK: Button action
    lazy var loginInAction: UIAction = .init(handler: { [weak self] _ in
        
    })
    
    lazy var registerAction: UIAction = .init(handler: { [weak self] _ in
        
    })
}
