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
        case checkmark
    }
    
    enum Icon {
        static let next = UIImage(systemName: "chevron.right.circle.fill")
        static let delete = UIImage(systemName: "trash.circle.fill")
        static let add = UIImage(systemName: "plus.circle.fill")
        static let close = UIImage(systemName: "xmark.circle.fill")
        static let checkmark = UIImage(systemName: "checkmark.circle.fill")
    }
    
    init(
        style: Style,
        action: UIAction
    ){
        super.init(frame: .zero)
        switch style {
        case .next:
            tintColor = .systemGray5
            setImage(Icon.next, for: .normal)
            contentVerticalAlignment = .fill
            contentHorizontalAlignment = .fill
            layer.cornerRadius = Config.nextButtonSize / 2
            widthAnchor.constraint(equalToConstant: Config.nextButtonSize).isActive = true
            heightAnchor.constraint(equalToConstant: Config.nextButtonSize).isActive = true
        case .delete:
            setImage(Icon.delete, for: .normal)
            tintColor = .white
            contentVerticalAlignment = .fill
            contentHorizontalAlignment = .fill
            layer.cornerRadius = Config.buttonSize / 2
            widthAnchor.constraint(equalToConstant: Config.buttonSize).isActive = true
            heightAnchor.constraint(equalToConstant: Config.buttonSize).isActive = true
            backgroundColor = .red.withAlphaComponent(Config.alfa)
        case .add:
            setImage(Icon.add, for: .normal)
            tintColor = .systemGray5
            contentVerticalAlignment = .fill
            contentHorizontalAlignment = .fill
            layer.cornerRadius = Config.buttonSize / 2
            widthAnchor.constraint(equalToConstant: Config.buttonSize).isActive = true
            heightAnchor.constraint(equalToConstant: Config.buttonSize).isActive = true
            backgroundColor = .systemBlue.withAlphaComponent(Config.alfa)
        case .close:
            tintColor = .white
            setImage(Icon.close, for: .normal)
            contentVerticalAlignment = .fill
            contentHorizontalAlignment = .fill
            layer.cornerRadius = Config.buttonSize / 2
            widthAnchor.constraint(equalToConstant: Config.buttonSize).isActive = true
            heightAnchor.constraint(equalToConstant: Config.buttonSize).isActive = true
            backgroundColor = .red.withAlphaComponent(Config.alfa)
        case .checkmark:
            tintColor = .white
            setImage(Icon.checkmark, for: .normal)
            contentVerticalAlignment = .fill
            contentHorizontalAlignment = .fill
            layer.cornerRadius = Config.buttonSize / 2
            widthAnchor.constraint(equalToConstant: Config.buttonSize).isActive = true
            heightAnchor.constraint(equalToConstant: Config.buttonSize).isActive = true
            backgroundColor = .green
        case .register:
            setTitle("Регистрация", for: .normal)
        case .loginIn:
            setTitle("Войти", for: .normal)
            backgroundColor = .systemGreen.withAlphaComponent(0.5)
        case .save:
            setTitle("Сохранить", for: .normal)
            backgroundColor = .systemGreen.withAlphaComponent(0.5)
        }
        translatesAutoresizingMaskIntoConstraints = false
        addAction(action, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
