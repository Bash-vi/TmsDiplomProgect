//
//  UserViewController.swift
//  AnyList
//
//  Created by Вячеслав Башур on 18/12/2024.
//

import UIKit

class UserViewController: UIViewController {
    
    lazy var label = AppLabel(style: .value)
    
    let network = NetWork()
    
    lazy var button = UIButton(type: .close, primaryAction: .init(handler: {[weak self] _ in
        self?.dismiss(animated: true)
    }))
    
    lazy var logOutButton = UIButton(type: .system, primaryAction: .init(handler: {[weak self] _ in
        self?.network.signOut()
        self?.dismiss(animated: true)
    }))
    
    let user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(logOutButton)
        logOutButton.setTitle("выход", for: .normal)
        logOutButton.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        guard let email = user.email else { return }
        label.text = "\(user.fullName) \n\(email)"
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            logOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Config.betweenView),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
