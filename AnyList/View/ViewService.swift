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
//        let icon = UIImageView()
//        icon.image = UIImage(systemName: "person.crop.circle")
//        icon.contentMode = .scaleAspectFit
//        icon.tintColor = .white
        
        let icon = AppIcon(style: .user)
      
        let fullnameLabel = AppLabel(style: .value)
        fullnameLabel.text = fullName
        
        let welcomeLabel = AppLabel(style: .subtitle)
        welcomeLabel.text = "Добро пожаловать"
        
        let fullNamestack = verticalStack(subviews: [welcomeLabel, fullnameLabel])
        
        let userInfoButton = AppButton(style: .next, action: userInfoAction)
        
        let stack = horisontStack(subviews: [icon ,fullNamestack, userInfoButton])
        stack.distribution = .fillProportionally
        return stack
    }
    
    func createWrapper() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
