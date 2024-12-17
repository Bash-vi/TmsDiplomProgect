//
//  CreateListRouter.swift
//  AnyList
//
//  Created by Вячеслав Башур on 16/12/2024.
//

import Foundation

protocol CreateListViewRouter {
    func build(list: List?, anyListView: AnyListViewController) -> CreateListViewController
    func close()
}

class CreateListViewDefaultRouter: CreateListViewRouter {
    
    weak var view: CreateListViewController?
    
    func build(list: List?, anyListView: AnyListViewController) -> CreateListViewController {
        let netWork = NetWork()
        let interactor = CreateListInteractor()
        let presenter = CreateListPresenter(interactor: interactor, router: self)
        let view = CreateListViewController()
        interactor.netWork = netWork
        presenter.view = view
        view.presenter = presenter
        view.delegate = anyListView
        view.list = list
        self.view = view
        return view
    }
    
    func close() {
        view?.dismiss(animated: true)
    }
}
