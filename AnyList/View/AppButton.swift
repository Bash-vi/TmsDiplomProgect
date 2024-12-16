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
        case next
        case delete
        case add
        case close
        case register
        case loginIn
        case save
    }
    
    enum Icon {
        static let next = UIImage(systemName: "chevron.right.circle.fill")
        static let delete = UIImage(systemName: "trash.circle.fill")
        static let add = UIImage(systemName: "plus.circle.fill")
        static let close = UIImage(systemName: "xmark.circle.fill")
    }
    
    init(
        style: Style,
        action: UIAction
    ){
        super.init(frame: .zero)
        switch style {
        case .next:
            self.setImage(Icon.next, for: .normal)
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
            tintColor = .green
            self.setImage(Icon.close, for: .normal)
            self.contentVerticalAlignment = .fill
            self.contentHorizontalAlignment = .fill
            self.layer.cornerRadius = Config.buttonSize / 2
            self.widthAnchor.constraint(equalToConstant: Config.buttonSize).isActive = true
            self.heightAnchor.constraint(equalToConstant: Config.buttonSize).isActive = true
            self.backgroundColor = .red
            
        case .register:
            self.setTitle("Регистрация", for: .normal)
        case .loginIn:
            self.setTitle("Войти", for: .normal)
            self.backgroundColor = .systemGreen.withAlphaComponent(0.5)
        case .save:
            self.setTitle("Сохранить", for: .normal)
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
