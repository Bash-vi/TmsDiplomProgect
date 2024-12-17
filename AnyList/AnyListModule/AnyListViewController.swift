//
//  AnyListViewController.swift
//  AnyList
//
//  Created by Вячеслав Башур on 13/12/2024.
//

import UIKit

protocol AnyListViewProtocol: AnyObject {
    func present(lists: [List])
    func present(user: User)
}

class AnyListViewController: UIViewController, AnyListViewProtocol {
    
    var presenter: AnyListPresenterActionHandler?
    
    @MainActor
    var user: User?
    
    @MainActor
    var lists: [List] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    let viewService = ViewService.shared
    
    let indent = Config.Indent.self
    
    lazy var anyListLabel = AppLabel(style: .anyList)
    
    lazy var fullNameLabel = AppLabel(style: .value)
    
    lazy var userStack = viewService.createUserStack(userInfoAction: userInfoAction, fullNameLabel: fullNameLabel)
    
    lazy var addStack = viewService.createAddStack(add: add)
    
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
        Task { await presenter?.load() }
        view.backgroundColor = .gray
        view.addSubview(anyListLabel)
        view.addSubview(userStack)
        view.addSubview(addStack)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            anyListLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            anyListLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            userStack.topAnchor.constraint(equalTo: anyListLabel.bottomAnchor, constant: Config.betweenView),
            userStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: indent.left),
            userStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: indent.right),
            
            addStack.topAnchor.constraint(equalTo: userStack.bottomAnchor, constant: Config.betweenView),
            addStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: indent.left),
            addStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: indent.right),
            
            tableView.topAnchor.constraint(equalTo: addStack.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: indent.left),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: indent.right),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func present(lists: [List]) {
        Task { self.lists = lists }
    }
    
    func present(user: User) {
        self.user = user
        Task { @MainActor in
            if self.user == nil {
                fullNameLabel.text = "Пожалуйста, зарегистрируйтесь"
            } else {
                fullNameLabel.text = user.fullName
            }
        }
    }
    
    //MARK: Button action
    lazy var userInfoAction: UIAction = .init(handler: { [weak self] _ in
        guard let self else { return }
        self.presenter?.openUserInfo()
    })
    
    lazy var add: UIAction = .init(handler: { [weak self] _ in
        guard let self else { return }
        self.presenter?.openCreateListView(list: nil)
    })
}

extension AnyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        guard let cell else { return UITableViewCell()}
        var config = cell.defaultContentConfiguration()
        let list = lists[indexPath.row]
        config.text = list.name
//        config.secondaryText = element.price
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let list = lists[indexPath.row]
        presenter?.openCreateListView(list: list)
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
