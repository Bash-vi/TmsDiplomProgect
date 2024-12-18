//
//  ElementsRouter.swift
//  AnyList
//
//  Created by Вячеслав Башур on 17/12/2024.
//

import Foundation

protocol ElementsViewRouter {
    func build(listId: String?) -> ElementsViewController
    func openCreateElementView(element: Element?, listId: String, elementsView: ElementsViewController)
    func close()
}

class ElementsViewDefaultRouter: ElementsViewRouter {
    
    weak var view: ElementsViewController?
    
    let CreateElementViewRouter: CreateElementViewRouter
    
    let CreateelementRouter = CreateElementViewDefaultRouter()
    
    init() {
        self.CreateElementViewRouter = CreateelementRouter
    }
    
    func build(listId: String?) -> ElementsViewController {
        let netWork = NetWork()
        let interactor = ElementsInteractor()
        let presenter = ElementsPresenter(interactor: interactor, router: self)
        let view = ElementsViewController()
        interactor.presenter = presenter
        interactor.netWork = netWork
        presenter.view = view
        view.presenter = presenter
        view.listId = listId
        self.view = view
        return view
    }
    
    func openCreateElementView(element: Element?, listId: String, elementsView: ElementsViewController) {
        let createElementView = CreateElementViewRouter.build(
            element: element, listId: listId, elementsView: elementsView
        )
        createElementView.modalPresentationStyle = .overFullScreen
        view?.present(createElementView, animated: true)
    }
    
    func close() {
        view?.dismiss(animated: true)
    }
}
