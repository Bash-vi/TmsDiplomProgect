//
//  AuthPresenter.swift
//  AnyList
//
//  Created by Вячеслав Башур on 15/12/2024.
//

import Foundation

protocol AuthPresenterActionHandler: AnyObject {
    func register(user: User) async
    func sighIn(email: String?, password: String?) async
    func openRegisterView()
    func closeRegisterView()
}

protocol AuthPresenterResultHandler: AnyObject {
    func present(errorText: String)
    func islogin(toggle: Bool)
    func isOpenApp(toggle: Bool)
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
    
    func sighIn(email: String?, password: String?) async {
        await interactor.sighIn(email: email, password: password)
    }
    
    func present(errorText: String) {
        view?.present(errorText: errorText)
    }
    
    //MARK: Navigation metods
    func openRegisterView() {
        router.openRegisterView()
    }
    
    func closeRegisterView() {
        router.closeRegisterView()
    }
    
    func isOpenApp(toggle: Bool) {
        if toggle == true {
            Task { @MainActor in router.authViewOpenApp() }
        }
    }
    
    func islogin(toggle: Bool) {
        if toggle == true {
            Task { @MainActor in router.registerViewOpenAuth() }
        }
    }
}
