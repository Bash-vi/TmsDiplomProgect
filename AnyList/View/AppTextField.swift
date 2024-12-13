//
//  AppTextField.swift
//  AnyList
//
//  Created by Вячеслав Башур on 13/12/2024.
//

import Foundation
import UIKit

class AppTextField: UITextField {
    
    init(
        placeholderText: String
    ) {
        super.init(frame: .zero)
        borderStyle = .roundedRect
        placeholder = placeholderText
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
