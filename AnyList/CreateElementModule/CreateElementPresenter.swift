//
//  CreateElementPresenter.swift
//  AnyList
//
//  Created by Вячеслав Башур on 17/12/2024.
//

import Foundation

protocol CreateElementPresenterActionHandler: AnyObject {
    func update(listId: String, elementId: String, element: Element) async
    func create(element: Element, listId: String) async
    func deleteElement(listId: String, elementId: String) async
    func close()
}

class CreateElementPresenter: CreateElementPresenterActionHandler {
    
    let interactor: CreateElementInteractorProtocol
    weak var view: CreateElementViewController?
    let router: CreateElementViewRouter
    
    init(
        interactor: CreateElementInteractorProtocol,
        router: CreateElementViewRouter
    ) {
        self.interactor = interactor
        self.router = router
    }
    
    func update(listId: String, elementId: String, element: Element) async {
        await interactor.update(listId: listId, elementId: elementId, element: element)
    }
    
    func create(element: Element, listId: String) async {
        await interactor.create(element: element, listId: listId)
    }
    
    func deleteElement(listId: String, elementId: String) async {
        await interactor.deleteElement(listId: listId, elementId: elementId)
    }
    
    func close() {
        router.close()
    }
    
}
