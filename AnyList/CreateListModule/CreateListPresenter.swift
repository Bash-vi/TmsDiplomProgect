//
//  CreateListPresenter.swift
//  AnyList
//
//  Created by Вячеслав Башур on 16/12/2024.
//

import Foundation

protocol CreateListPresenterActionHandler: AnyObject {
    func save(list: List) async
    func update(listId: String, newList: List) async
    func delete(listId: String) async
    func close()
}

class CreateListPresenter: CreateListPresenterActionHandler {

    let interactor: CreateListInteractorProtocol
    weak var view: CreateListViewController?
    let router: CreateListViewRouter
    
    init(
        interactor: CreateListInteractorProtocol,
        router: CreateListViewRouter
    ) {
        self.interactor = interactor
        self.router = router
    }
    
    func save(list: List) async {
        await interactor.save(list: list)
    }
    
    func update(listId: String, newList: List) async {
        await interactor.update(listId: listId, newList: newList)
    }
    
    func delete(listId: String) async {
        await interactor.delete(listId: listId)
    }
    
    func close() {
        router.close()
    }
    
}
