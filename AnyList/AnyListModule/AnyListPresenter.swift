//
//  AnyListPresenter.swift
//  AnyList
//
//  Created by Вячеслав Башур on 16/12/2024.
//

import Foundation

protocol AnyListPresenterActionHandler: AnyObject {
    func refresh() async
    func load() async
    func signOut()
    func openCreateListView(list: List?, anyListView: AnyListViewController)
    func openUserInfo()
}

protocol AnyListPresenterResultHandler: AnyObject {
    func present(lists: [List])
    func present(user: User)
}

class AnyListPresenter: AnyListPresenterActionHandler, AnyListPresenterResultHandler {
    
    let interactor: AnyListInteractorProtocol
    weak var view: AnyListViewProtocol?
    let router: AnyListViewRouter
    
    init(
        interactor: AnyListInteractorProtocol,
        router: AnyListViewRouter
    ) {
        self.interactor = interactor
        self.router = router
    }
    
    func signOut() {
        interactor.signOut()
    }
    
    func refresh() async {
        await interactor.refresh()
    }
    
    func load() async {
        await interactor.Load()
    }
    
    func present(lists: [List]) {
        view?.present(lists: lists)
    }
    
    func present(user: User) {
        view?.present(user: user)
    }
    
    //MARK: Navigation metods
    func openCreateListView(list: List?, anyListView: AnyListViewController) {
        router.openCreateListView(list: list, anyListView: anyListView)
    }
    
    func openUserInfo() {
        
    }
}
