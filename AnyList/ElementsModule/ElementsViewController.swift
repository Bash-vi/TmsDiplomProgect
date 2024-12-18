//
//  ElementsViewController.swift
//  AnyList
//
//  Created by Вячеслав Башур on 17/12/2024.
//

import UIKit

protocol ElementsViewControllerDelegate: AnyObject {
    func reloadData(listId: String) async
}

protocol ElementsViewProtocol: AnyObject {
    func present(elements: [Element])
}

class ElementsViewController: UIViewController, ElementsViewProtocol {

    var presenter: ElementsPresenterActionHandler?
    
    var listId: String?
    
    var isSettingButtonOn = false
    
    @MainActor
    var elements: [Element] = [] {
        didSet{
            tableView.reloadData()
        }
    }

    let indent = Config.Indent.self
    
    lazy var titleLabel = AppLabel(style: .pagetitle)
    
    lazy var closeButton = AppButton(style: .close, action: close)
    
    lazy var settingButton = AppButton(style: .settings, action: settingsAction)
    
    let settingButton2 = UIButton(type: .close)
    
    lazy var addButton = AppButton(style: .add, action: add)
    
    lazy var titleStack = UIStackView(arrangedSubviews: [closeButton, titleLabel, addButton])
    
    lazy var buttonStack = UIStackView(arrangedSubviews: [settingButton, settingButton2])
    
    let reuseId = "element"
    
    lazy var tableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Элементы"
        Task {
            guard let listId else { return }
            await presenter?.load(listId: listId)
        }
        view.backgroundColor = .gray
        view.addSubview(titleStack)
        view.addSubview(buttonStack)
        view.addSubview(tableView)
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: indent.left),
            titleStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: indent.right),
            
            buttonStack.topAnchor.constraint(equalTo: titleStack.bottomAnchor, constant: Config.betweenView),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: indent.left),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: indent.right),
            
            tableView.topAnchor.constraint(equalTo: buttonStack.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: indent.left),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: indent.right),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func present(elements: [Element]) {
        Task { self.elements = elements }
    }
    
    //MARK: Button action
    lazy var close: UIAction = .init(handler: { [weak self] _ in
        guard let self else { return }
        self.presenter?.close()
    })
    
    lazy var settingsAction: UIAction = .init(handler: { [weak self] _ in
        guard let self else { return }
        isSettingButtonOn.toggle()
        tableView.reloadData()
        if isSettingButtonOn {
        self.settingButton.tintColor = .yellow
    } else {
        self.settingButton.tintColor = .white
    }})
    
    lazy var add: UIAction = .init(handler: { [weak self] _ in
        guard let self else { return }
        guard let listId else { return }
        self.presenter?.openCreateElementView(element: nil, listId: listId, elementsView: self)
    })
}


extension ElementsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: ElementCell.reuseId) as? ElementCell
//        guard let cell else { return UITableViewCell()}
//        let element = elements[indexPath.row]
//        
//        cell.setElement(isActive: element.isActive, name: element.name, message: element.message)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId)
        guard let cell else { return UITableViewCell()}
        var config = cell.defaultContentConfiguration()
        let element = elements[indexPath.row]
        config.text = element.name
        config.secondaryText = element.message
        cell.contentConfiguration = config
        if isSettingButtonOn {
            cell.backgroundColor = .yellow.withAlphaComponent(Config.Cell.alfa)
        } else {
            cell.backgroundColor = .white
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let element = elements[indexPath.row]
        guard let listId else { return }
        
        if isSettingButtonOn {
            presenter?.openCreateElementView(element: element, listId: listId, elementsView: self)
        } else {
            guard var isActive = element.isActive else { return }
            if isActive {
                isActive.toggle()
                let newElement = element
                Task {
                    await presenter?.update(listId: listId, elementId: newElement.id, element: newElement)
                    await presenter?.refresh(listId: listId)
                }
            } else {
                isActive.toggle()
                let newElement = element
                Task {
                    await presenter?.update(listId: listId, elementId: newElement.id, element: newElement)
                    await presenter?.refresh(listId: listId)
                }
            }
        }
    }
}

extension ElementsViewController: ElementsViewControllerDelegate {
    func reloadData(listId: String) async {
        await presenter?.refresh(listId: listId)
    }
}
