//
//  CreateElementViewController.swift
//  AnyList
//
//  Created by Вячеслав Башур on 17/12/2024.
//

import UIKit

class CreateElementViewController: UIViewController {

    var presenter: CreateElementPresenterActionHandler?
    
    weak var delegate: ElementsViewControllerDelegate?
    
    var listId: String?
    
    var element: Element?
    
    let indent = Config.Indent.self
    
    let service = ViewService.shared
    
    var titleText: String {
        if element != nil { return "Изменить" } else { return "Создать" }
    }
    
    lazy var titleLabel = AppLabel(style: .pagetitle)
    
    lazy var nameField = AppTextField(placeholderText: "Название элемента")
    
    lazy var messageField = AppTextField(placeholderText: "Важное сообщение")
    
    lazy var deleteButton = AppButton(style: .delete, action: delete)
    
    lazy var saveButton = AppButton(style: .checkmark, action: save)
    
    lazy var closeButton = AppButton(style: .close, action: close)
    
    lazy var titleStack = UIStackView(arrangedSubviews: [closeButton, deleteButton, titleLabel, saveButton])
    
    lazy var stack = service.verticalStack(subviews: [
        titleStack, nameField, messageField
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        titleLabel.text = titleText
        
        if element == nil {
            deleteButton.isHidden = true
        } else {
            deleteButton.isHidden = false
            guard let element else { return }
            nameField.text = element.name
            messageField.text = element.message
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
        guard let listId = self.listId else { return }
        guard let name = self.nameField.text, !name.isEmpty else { return
            self.nameField.text = "Введите название элемента"
        }
        let message = self.messageField.text
        
        if element == nil {
            let newElement: Element = .init(message: message, name: name, isActive: true)
            Task {
                await self.presenter?.create(element: newElement, listId: listId )
                await self.delegate?.reloadData(listId: listId)
            }
        } else {
            guard let id = self.element?.id else { return }
            let updatedElement: Element = .init(message: message, name: name, isActive: true)
            Task {
                
                await self.presenter?.update(listId: listId, elementId: id, element: updatedElement)
                await self.delegate?.reloadData(listId: listId)
            }}
        self.presenter?.close()
    })
    
    lazy var close: UIAction = .init(handler: { [weak self] _ in
        guard let self else { return }
        self.presenter?.close()
    })
    
    lazy var delete: UIAction = .init(handler: { [weak self] _ in
        guard let self else { return }
        guard let listId = self.listId else { return }
        guard let deletedElementId = self.element?.id else { return }
        Task {
            await self.presenter?.deleteElement(listId: listId, elementId: deletedElementId)
            await self.delegate?.reloadData(listId: listId)
        }
        self.presenter?.close()
    })
}
