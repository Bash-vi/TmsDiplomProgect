//
//  ElementsInteractor.swift
//  AnyList
//
//  Created by Вячеслав Башур on 17/12/2024.
//

import Foundation

protocol ElementsInteractorProtocol {
    func Load (listId: String) async
    func refresh(listId: String) async
    func update(listId: String, elementId: String, element: Element) async
    
}

class ElementsInteractor: ElementsInteractorProtocol {
    
    weak var presenter: ElementsPresenterResultHandler?
    
    var netWork: NetWorkAnyListProtocol?
    
    func Load (listId: String) async {
        let elements = await netWork?.readElements(listId: listId)
        guard let elements else { return }
        presenter?.present(elements: elements)
    }
    
    func refresh(listId: String) async {
        let elements = await netWork?.readElements(listId: listId)
        guard let elements else { return }
        presenter?.present(elements: elements)
    }
    
    func update(listId: String, elementId: String, element: Element) async {
        await netWork?.update(listId: listId, elementId: elementId, element: element)
    }
}
