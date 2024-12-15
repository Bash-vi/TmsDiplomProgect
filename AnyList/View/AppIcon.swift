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
    }
    
    enum Icon {
        static let user = UIImage(systemName: "person.crop.circle")
    }
    
    init(
        style: Style
    ) {
        super.init(frame: .zero)
        switch style {
        case .user:
            image = Icon.user
        }
        contentMode = .scaleAspectFit
        tintColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .init(width: 8, height: 8)
        layer.shadowOpacity = 0.3
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
