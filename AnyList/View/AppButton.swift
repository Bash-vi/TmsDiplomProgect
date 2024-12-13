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
        case replace
        case save
    }
    
    enum Icon {
        static let edit = UIImage(systemName: "pencil.circle.fill")
        static let delete = UIImage(systemName: "trash.circle.fill")
        static let add = UIImage(systemName: "plus.circle.fill")
        static let close = UIImage(systemName: "x.circle.fill")
        static let replace = UIImage(systemName: "arrow.clockwise.circle.fill")
        static let save = UIImage(systemName: "checkmark.circle.fill")
    }
    
    init(
        style: Style,
        action: UIAction
    ){
        super.init(frame: .zero)
        switch style {
        case .edit:
            self.setImage(Icon.edit, for: .normal)
        case .delete:
            self.setImage(Icon.delete, for: .normal)
        case .add:
            self.setImage(Icon.add, for: .normal)
        case .close:
            self.setImage(Icon.close, for: .normal)
            self.backgroundColor = .red
        case .replace:
            self.setImage(Icon.replace, for: .normal)
        case .save:
            self.setImage(Icon.save, for: .normal)
            self.backgroundColor = .systemGreen
        }
        self.addAction(action, for: .touchUpInside)
        self.tintColor = .systemGray3
        self.backgroundColor = .black
        self.contentVerticalAlignment = .fill
        self.contentHorizontalAlignment = .fill
        self.layer.cornerRadius = Config.buttonSize / 2
        self.widthAnchor.constraint(equalToConstant: Config.buttonSize).isActive = true
        self.heightAnchor.constraint(equalToConstant: Config.buttonSize).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
