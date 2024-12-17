//
//  CreateListInteractor.swift
//  AnyList
//
//  Created by Вячеслав Башур on 16/12/2024.
//

import Foundation

protocol CreateListInteractorProtocol {
    func save(list: List) async
    func update(listId: String, newList: List) async
    func delete(listId: String) async
}

class CreateListInteractor: CreateListInteractorProtocol {
   
    var netWork: NetWorkAnyListProtocol?
    
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
