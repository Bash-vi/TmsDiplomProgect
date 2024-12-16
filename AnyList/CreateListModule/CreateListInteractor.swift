//
//  CreateListInteractor.swift
//  AnyList
//
//  Created by Вячеслав Башур on 16/12/2024.
//

import Foundation

protocol CreateListInteractorProtocol {
    func save(list: List) async
    func update(list: List)
}

class CreateListInteractor: CreateListInteractorProtocol {
   
    var netWork: NetWorkAnyListProtocol?
    
    func save(list: List) async {
        await netWork?.create(list: list)
    }
    
    func update(list: List) {
        
    }
}
