//
//  ViewService.swift
//  AnyList
//
//  Created by Вячеслав Башур on 13/12/2024.
//

import Foundation
import UIKit

class ViewService {
    static let shared = ViewService()
    
    func horisontStack(subviews:[UIView]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: subviews)
        stack.axis = .horizontal
        stack.spacing = Config.spacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    func verticalStack(subviews:[UIView]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: subviews)
        stack.spacing = Config.spacing
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    func createWrapper() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
