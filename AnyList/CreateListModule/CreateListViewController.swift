//
//  CreateListViewController.swift
//  AnyList
//
//  Created by Вячеслав Башур on 16/12/2024.
//

import UIKit

class CreateListViewController: UIViewController {

    var presenter: CreateListPresenterActionHandler?
    
    weak var delegate: AnyListViewControllerDelegate?
    
    var list: List?
    
    let indent = Config.Indent.self
    
    let service = ViewService.shared
    
    var titleText: String {
        if list != nil { return "Изменить" } else { return "Создать" }
    }
    
    lazy var nameField = AppTextField(placeholderText: "Название списка")
    
    lazy var deleteButton = AppButton(style: .delete, action: delete)
    
    lazy var stack = service.createListStack(
        textField: nameField, titleText: titleText, close: close, save: save, deleteButton: deleteButton
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        if list == nil {
            deleteButton.isHidden = true
        } else {
            deleteButton.isHidden = false
            guard let list else { return }
            nameField.text = list.name
        }
        
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: indent.left),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: indent.right),
        ])
    }
    
    //MARK: Button action
    lazy var save: UIAction = .init(handler: { [weak self] _ in
        guard let self else { return }
        guard let name = self.nameField.text, !name.isEmpty else { return
            self.nameField.text = "Введите название списка"
        }
        
        if list == nil {
            let newList: List = .init(name: name)
            Task {
                await self.presenter?.save(list: newList)
                await self.delegate?.reloadData()
            }
        } else {
                let updatedList: List = .init(name: name)
            Task {
                guard let id = self.list?.id else { return }
                await self.presenter?.update(listId: id, newList: updatedList)
                await self.delegate?.reloadData()
            }}
        self.presenter?.close()
    })
    
    lazy var close: UIAction = .init(handler: { [weak self] _ in
        guard let self else { return }
        self.presenter?.close()
    })
    
    lazy var delete: UIAction = .init(handler: { [weak self] _ in
        guard let self else { return }
        guard let deletedList = self.list else { return }
        Task {
            await self.presenter?.delete(listId: deletedList.id)
            await self.delegate?.reloadData()
        }
        self.presenter?.close()
    })
}
