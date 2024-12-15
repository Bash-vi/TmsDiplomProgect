//
//  AnyListViewController.swift
//  AnyList
//
//  Created by Вячеслав Башур on 13/12/2024.
//

import UIKit

class AnyListViewController: UIViewController {
    
    @MainActor
    var user: User?
    
    @MainActor
    var list: [Element] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    let viewService = ViewService.shared
    
    let indent = Config.Indent.self
    
    var fullName: String {
        guard let user else { return "Пожалуйста, зарегистрируйтесь"}
        return user.fullName
    }
    
    lazy var anyListLabel = AppLabel(style: .anyList)
    
    lazy var userStack = viewService.createUserStack(userInfoAction: userInfoAction, fullName: fullName)
    
    lazy var tableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        return table
    }()
    
    let cellId = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(anyListLabel)
        view.addSubview(userStack)
        view.addSubview(tableView)
        list = [.init(price: "22", name: "2dsg"), .init(price: "22", name: "2dsg"), .init(price: "22", name: "2dsg")]
        NSLayoutConstraint.activate([
            anyListLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            anyListLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            userStack.topAnchor.constraint(equalTo: anyListLabel.bottomAnchor, constant: Config.spacing),
            userStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: indent.left),
            userStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: indent.right),
            
            tableView.topAnchor.constraint(equalTo: userStack.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: indent.left),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: indent.right),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK: Button action
    lazy var userInfoAction: UIAction = .init(handler: { [weak self] _ in
        
    })
    
    lazy var add: UIAction = .init(handler: { [weak self] _ in
        
    })
}

extension AnyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        guard let cell else { return UITableViewCell()}
        var config = cell.defaultContentConfiguration()
        let element = list[indexPath.row]
        config.text = element.name
        config.secondaryText = element.price
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return .init(actions: [.init(style: .destructive, title: "удалить", handler: { [weak self] _,_,_  in
//            let elementId = self?.list[indexPath.row].id
//            guard let elementId else { return }
//            Task {
//                await self?.elementService.delete(elementId: elementId)
//                self?.loadUserData()
//            }
        })])
    }
}
