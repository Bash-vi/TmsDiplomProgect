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
    func openElementsView(listId: String?)
}

class AnyListViewDefaultRouter: AnyListViewRouter {
    
    weak var view: UIViewController?
    
    let elementsViewRouter: ElementsViewRouter
    let elementsRouter = ElementsViewDefaultRouter()
    
    let createListViewRouter: CreateListViewRouter
    let createListRouter = CreateListViewDefaultRouter()
    
    init() {
        self.createListViewRouter = createListRouter
        self.elementsViewRouter = elementsRouter
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
        let createListView = createListViewRouter.build(list: list, anyListView: anyListView)
        createListView.modalPresentationStyle = .overFullScreen
        view?.present(createListView, animated: true)
    }
    
    func openElementsView(listId: String?) {
        let elementsView = elementsViewRouter.build(listId: listId)
        elementsView.modalPresentationStyle = .overFullScreen
        view?.present(elementsView, animated: true)
    }
}
