//
//  AuthRouter.swift
//  AnyList
//
//  Created by Вячеслав Башур on 15/12/2024.
//

import UIKit

protocol AuthViewRouter {
    func build() -> RegisterViewController
    func openRegisterView()
}

class AuthDefaultRouter: AuthViewRouter {
    weak var view: AuthViewController?
    
    var detailViewRouter: DetailViewRouter?
    
    func build() -> RegisterViewController {
        let interactor = AuthInteractor()
        let presenter = AuthPresenter(interactor: interactor, router: self)
        let view = RegisterViewController()
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
//        self.view = view
        return view
    }
    
    func openRegisterView() {
        
    }
    
    func openDetailView(string: String) {
//        let detailView = detailViewRouter?.build(name: string)
//        view?.present(detailView, animated: true)
    }
}

protocol DetailViewRouter {
    func build(name: String) -> UIViewController
}

class registerroter: DetailViewRouter {
    func build(name: String) -> UIViewController {
        return UIViewController()
    }
    
    
}
