//
//  AuthRouter.swift
//  AnyList
//
//  Created by Вячеслав Башур on 15/12/2024.
//

import UIKit

protocol AuthViewRouter {
    func buildAuthView() -> AuthViewController
    func buildRegisterView() -> RegisterViewController
    func openRegisterView()
    func closeRegisterView()
    func authViewOpenApp()
    func registerViewOpenAuth()
}

class AuthDefaultRouter: AuthViewRouter {
    let netWork = NetWork()
    
    let anyListViewRouter: AnyListViewRouter
    
    let anyListRouter = AnyListViewDefaultRouter()
    
    init() {
        self.anyListViewRouter = anyListRouter
    }
    
    weak var authView: AuthViewController?
    
    weak var registerView: RegisterViewController?
    
    func buildAuthView() -> AuthViewController {
        let interactor = AuthInteractor()
        let presenter = AuthPresenter(interactor: interactor, router: self)
        let view = AuthViewController()
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.netWork = netWork
        presenter.view = view
        self.authView = view
        return view
    }
    
    func buildRegisterView() -> RegisterViewController {
        let interactor = AuthInteractor()
        let presenter = AuthPresenter(interactor: interactor, router: self)
        let view = RegisterViewController()
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.netWork = netWork
        presenter.view = view
        self.registerView = view
        return view
    }
    
    func openRegisterView() {
        let registerView = buildRegisterView()
        registerView.modalPresentationStyle = .overFullScreen
        authView?.present(registerView, animated: true)
    }
    
    func registerViewOpenAuth() {
        let authView = buildAuthView()
        authView.modalPresentationStyle = .overFullScreen
        registerView?.present(authView, animated: true)
    }
    
    func authViewOpenApp() {
        let anyListView = anyListViewRouter.build()
        anyListView.modalPresentationStyle = .overFullScreen
        authView?.present(anyListView, animated: true)
    }
    
    func closeRegisterView() {
        registerView?.dismiss(animated: true)
    }
}

