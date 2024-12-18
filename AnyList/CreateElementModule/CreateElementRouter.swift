//
//  CreateElementRouter.swift
//  AnyList
//
//  Created by Вячеслав Башур on 17/12/2024.
//

import Foundation

protocol CreateElementViewRouter {
    func build(element: Element?, listId: String, elementsView: ElementsViewController) -> CreateElementViewController
    func close()
}

class CreateElementViewDefaultRouter: CreateElementViewRouter {
    
    weak var view: CreateElementViewController?
    
    func build(
        element: Element?, listId: String,
        elementsView: ElementsViewController
    ) -> CreateElementViewController {
        let netWork = NetWork()
        let interactor = CreateElementInteractor()
        let presenter = CreateElementPresenter(interactor: interactor, router: self)
        let view = CreateElementViewController()
        interactor.netWork = netWork
        presenter.view = view
        view.presenter = presenter
        view.delegate = elementsView
        view.listId = listId
        view.element = element
        self.view = view
        return view
    }
    
    func close() {
        view?.dismiss(animated: true)
    }
}
