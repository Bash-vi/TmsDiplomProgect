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
}

class AuthDefaultRouter: AuthViewRouter {
    
    let netWork = NetWork()
    
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
        authView?.present(registerView, animated: true)
    }
    
    func closeRegisterView() {
        registerView?.dismiss(animated: true)
    }
}

//protocol RegisterViewRouter {
//    func build() -> RegisterViewController
//}
//
//class RegisterDefaultRoter: RegisterViewRouter {
//    func build() -> RegisterViewController {
//        let interactor = AuthInteractor()
//        let presenter = AuthPresenter(interactor: interactor, router: self)
//        let view = RegisterViewController()
//        view.presenter = presenter
//        interactor.presenter = presenter
//        presenter.view = view
//    }
//}
