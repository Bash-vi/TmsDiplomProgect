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
    
    func createUserStack(userInfoAction: UIAction, fullName: String) -> UIStackView {
        let fullnameLabel = AppLabel(style: .value)
        fullnameLabel.text = fullName
        
        let welcomeLabel = AppLabel(style: .subtitle)
        welcomeLabel.text = "Добро пожаловать"
        
        let fullNamestack = verticalStack(subviews: [welcomeLabel, fullnameLabel])
        
        let userInfoButton = AppButton(style: .next, action: userInfoAction)
        
        let stack = horisontStack(subviews: [fullNamestack, userInfoButton])
        stack.distribution = .fillProportionally
        return stack
    }
    
    func createListStack(textField: UITextField, titleText: String ,close: UIAction, save: UIAction) -> UIStackView {
        let nameField = textField
        
        let subtiteLabel = AppLabel(style: .subtitle)
        subtiteLabel.text = titleText
        
        let closeButton = AppButton(style: .close, action: close)
        
        let saveButton = AppButton(style: .checkmark, action: save)
        
        let titleStack = UIStackView(arrangedSubviews: [closeButton, subtiteLabel, saveButton])
        
        let stack = verticalStack(subviews: [titleStack, nameField])
        stack.backgroundColor = .gray
        return stack
    }
    
    func createAddStack(add: UIAction) -> UIStackView {
        let titleLabel = AppLabel(style: .pagetitle)
        titleLabel.text = "Мои Списки"
        
        let addButton = AppButton(style: .add, action: add)
        let stack = horisontStack(subviews: [titleLabel, addButton])
        return stack
    }
    
    func createWrapper() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
