//
//  CreateListViewController.swift
//  AnyList
//
//  Created by Вячеслав Башур on 16/12/2024.
//

import UIKit

class CreateListViewController: UIViewController {

    var presenter: CreateListPresenterActionHandler?
    
    var list: List?
    
    let indent = Config.Indent.self
    
    let service = ViewService.shared
    
    var titleText: String {
        if list != nil { return "Изменить" } else { return "Создать" }
    }
    
    let nameField = AppTextField(placeholderText: "Название списка")
    
    lazy var stack = service.createListStack(textField: nameField, titleText: titleText, close: close, save: save)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: indent.left),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: indent.left),
        ])
    }
    
    //MARK: Button action
    lazy var save: UIAction = .init(handler: { [weak self] _ in
        guard let self, let name = nameField.text else { return }
        
        if list != nil {
            let newList: List = .init(name: name)
            Task { await self.presenter?.save(list: newList) }
    } else {
        
    }})
    
    lazy var close: UIAction = .init(handler: { [weak self] _ in
        guard let self else { return }
        self.presenter?.close()
    })
}
