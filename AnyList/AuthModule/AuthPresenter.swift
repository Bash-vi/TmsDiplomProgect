//
//  AuthPresenter.swift
//  AnyList
//
//  Created by Вячеслав Башур on 15/12/2024.
//

import Foundation

protocol AuthPresenterActionHandler: AnyObject {
    func register(user: User) async
}

protocol AuthPresenterResultHandler: AnyObject {
    func present(errorText: String)
}

class AuthPresenter: AuthPresenterActionHandler, AuthPresenterResultHandler {
    
    let interactor: AuthInteractorProtocol
    weak var view: AuthViewProtocol?
    let router: AuthViewRouter
    
    init(
        interactor: AuthInteractorProtocol,
        router: AuthViewRouter
    ) {
        self.interactor = interactor
        self.router = router
    }
    
    func register(user: User) async  {
        await interactor.register(user: user)
    }
    
    
    func present(errorText: String) {
        view?.present(errorText: errorText)
    }
    
    func openRegisterView() {
        router.openRegisterView()
    }
}
