//
//  AnyListRouter.swift
//  AnyList
//
//  Created by Вячеслав Башур on 16/12/2024.
//

import UIKit

protocol AnyListViewRouter {
    func build() -> AnyListViewController
    func openCreateListView(list: List?, anyListView: AnyListViewController)
}

class AnyListViewDefaultRouter: AnyListViewRouter {
    
    weak var view: UIViewController?
    
    let CreateListViewRouter: CreateListViewRouter
    
    let CreateListRouter = CreateListViewDefaultRouter()
    
    init() {
        self.CreateListViewRouter = CreateListRouter
    }
    
    func build() -> AnyListViewController {
        let netWork = NetWork()
        let interactor = AnyListInteractor()
        let presenter = AnyListPresenter(interactor: interactor, router: self)
        let view = AnyListViewController()
        interactor.presenter = presenter
        interactor.netWork = netWork
        presenter.view = view
        view.presenter = presenter
        self.view = view
        return view
    }
    
    func openCreateListView(list: List?, anyListView: AnyListViewController) {
        let createListView = CreateListViewRouter.build(list: list, anyListView: anyListView)
        createListView.modalPresentationStyle = .overFullScreen
        view?.present(createListView, animated: true)
    }
}
