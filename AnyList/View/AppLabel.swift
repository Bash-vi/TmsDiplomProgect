//
//  AppLabel.swift
//  AnyList
//
//  Created by Вячеслав Башур on 13/12/2024.
//

import Foundation
import UIKit

class AppLabel: UILabel {
    enum Style {
        case pagetitle
        case subtitle
        case value
        case header
    }
    
    enum LabelFont {
        static let pagetitle = UIFont.systemFont(ofSize: 26, weight: .bold)
        static let subtitle = UIFont.systemFont(ofSize: 16, weight: .light)
        static let value = UIFont.systemFont(ofSize: 18, weight: .regular)
    }
    
    init(
        style: Style
    ){
        super.init(frame: .zero)
        switch style {
        case .pagetitle:
            self.font = LabelFont.pagetitle
            self.textAlignment = .center
            self.numberOfLines = 0
        case .subtitle:
            self.font = LabelFont.subtitle
            self.textColor = .systemGray3
            self.widthAnchor.constraint(equalToConstant: Config.titleLabelWidth).isActive = true
        case .value :
            self.textAlignment = .left
            self.font = LabelFont.value
            self.numberOfLines = 0
        case .header:
            self.font = .systemFont(ofSize: 24, weight: .semibold)
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
