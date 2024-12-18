//
//  CreateElementInteractor.swift
//  AnyList
//
//  Created by Вячеслав Башур on 17/12/2024.
//

import Foundation

protocol CreateElementInteractorProtocol {
    func update(listId: String, elementId: String, element: Element) async
    func create(element: Element, listId: String) async
    func deleteElement(listId: String, elementId: String) async
}

class CreateElementInteractor: CreateElementInteractorProtocol {
    
    var netWork: NetWorkAnyListProtocol?
    
    func update(listId: String, elementId: String, element: Element) async {
        await netWork?.update(listId: listId, elementId: elementId, element: element)
    }
    
    func create(element: Element, listId: String) async {
        await netWork?.create(element: element, listId: listId)
    }
    
    func deleteElement(listId: String, elementId: String) async {
        await netWork?.deleteElement(listId: listId, elementId: elementId)
    }
    
   
    
    
    func save(list: List) async {
        await netWork?.create(list: list)
    }
    
    func update(listId: String, newList: List) async {
        await netWork?.update(listId: listId, newList: newList)
    }
    
    func delete(listId: String) async {
        await netWork?.delete(listId: listId)
    }
}
