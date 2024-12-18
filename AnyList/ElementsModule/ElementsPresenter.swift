//
//  ElementsPresenter.swift
//  AnyList
//
//  Created by Вячеслав Башур on 17/12/2024.
//

import Foundation

protocol ElementsPresenterActionHandler: AnyObject {
    func refresh(listId: String) async
    func load(listId: String) async
    func openCreateElementView(element: Element?, listId: String, elementsView: ElementsViewController)
    func close()
}

protocol ElementsPresenterResultHandler: AnyObject {
    func present(elements: [Element])
}

class ElementsPresenter: ElementsPresenterResultHandler, ElementsPresenterActionHandler {
    
    let interactor: ElementsInteractorProtocol
    weak var view: ElementsViewProtocol?
    let router: ElementsViewRouter
    
    init(
        interactor: ElementsInteractorProtocol,
        router: ElementsViewRouter
    ) {
        self.interactor = interactor
        self.router = router
    }
    
    func refresh(listId: String) async {
        await interactor.refresh(listId: listId)
    }
    
    func load(listId: String) async {
        await interactor.Load(listId: listId)
    }
    
    func present(elements: [Element]) {
        view?.present(elements: elements)
    }
    
    //MARK: Navigation metods
    func openCreateElementView(element: Element?, listId: String, elementsView: ElementsViewController) {
        router.openCreateElementView(element: element, listId: listId, elementsView: elementsView)
    }
    
    func close() {
        router.close()
    }
}
