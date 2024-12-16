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
        case anyList
        case pagetitle
        case subtitle
        case value
        case error
    }
    
    enum LabelFont {
        static let pagetitle = UIFont.systemFont(ofSize: 26, weight: .bold)
        static let subtitle = UIFont.systemFont(ofSize: 24, weight: .regular)
        static let value = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let anyList = UIFont.systemFont(ofSize: 34, weight: .thin)
        static let error = UIFont.systemFont(ofSize: 16, weight: .light)
    }
    
    init(
        style: Style
    ){
        super.init(frame: .zero)
        switch style {
        case .anyList:
            self.text = "AnyList"
            self.font = LabelFont.anyList
            self.textAlignment = .center
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = .init(width: 6, height: 6)
            self.layer.shadowOpacity = 0.8
        case .pagetitle:
            self.font = LabelFont.pagetitle
            self.textAlignment = .center
            self.numberOfLines = 0
        case .subtitle:
            self.font = LabelFont.subtitle
            self.textColor = .systemGray3
        case .value:
            self.font = LabelFont.value
            self.numberOfLines = 0
        case .error:
            self.font = LabelFont.error
            self.textAlignment = .center
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
