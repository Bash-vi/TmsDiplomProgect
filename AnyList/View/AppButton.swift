//
//  AppButton.swift
//  AnyList
//
//  Created by Вячеслав Башур on 13/12/2024.
//

import Foundation
import UIKit

class AppButton: UIButton {
    enum Style {
        case edit
        case delete
        case add
        case close
        case register
        case loginIn
    }
    
    enum Icon {
        static let edit = UIImage(systemName: "pencil.circle.fill")
        static let delete = UIImage(systemName: "trash.circle.fill")
        static let add = UIImage(systemName: "plus.circle.fill")
        static let close = UIImage(systemName: "x.circle.fill")
    }
    
    init(
        style: Style,
        action: UIAction
    ){
        super.init(frame: .zero)
        switch style {
        case .edit:
            self.setImage(Icon.edit, for: .normal)
            self.contentVerticalAlignment = .fill
            self.contentHorizontalAlignment = .fill
            self.layer.cornerRadius = Config.buttonSize / 2
            self.widthAnchor.constraint(equalToConstant: Config.buttonSize).isActive = true
            self.heightAnchor.constraint(equalToConstant: Config.buttonSize).isActive = true
        case .delete:
            self.setImage(Icon.delete, for: .normal)
        case .add:
            self.setImage(Icon.add, for: .normal)
        case .close:
            self.setImage(Icon.close, for: .normal)
            self.backgroundColor = .red
        case .register:
            self.setTitle("Регистрация", for: .normal)
        case .loginIn:
            self.setTitle("Войти", for: .normal)
            self.backgroundColor = .systemGreen.withAlphaComponent(0.5)
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addAction(action, for: .touchUpInside)
        self.tintColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
