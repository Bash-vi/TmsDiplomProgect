//
//  AppIcon.swift
//  AnyList
//
//  Created by Вячеслав Башур on 15/12/2024.
//

import UIKit

class AppIcon: UIImageView {
    
    enum Style {
        case user
        case list
    }
    
    enum Icon {
        static let user = UIImage(systemName: "person.crop.circle")
        static let list = UIImage(systemName: "list.bullet.rectangle")
    }
    
    init(
        style: Style
    ) {
        super.init(frame: .zero)
        switch style {
        case .user:
            image = Icon.user
            contentMode = .scaleAspectFit
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = .init(width: 8, height: 8)
            layer.shadowOpacity = 0.3
        case .list:
            image = Icon.list
            contentMode = .scaleAspectFit
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = .init(width: 8, height: 8)
            layer.shadowOpacity = 0.3
            heightAnchor.constraint(equalToConstant: Config.listIconSize).isActive = true
            widthAnchor.constraint(equalToConstant: Config.listIconSize).isActive = true
        }
        tintColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
