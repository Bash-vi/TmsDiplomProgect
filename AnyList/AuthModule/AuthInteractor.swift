//
//  AuthInteractor.swift
//  AnyList
//
//  Created by Вячеслав Башур on 15/12/2024.
//

import Foundation

protocol AuthInteractorProtocol {
    func register(user: User) async
    func sighIn(email: String?, password: String?) async
}

class AuthInteractor: AuthInteractorProtocol {
    weak var presenter: AuthPresenterResultHandler?
    
    var netWork: NetWorkAuthProtocol?
    
    func register(user: User) async {
        do {
            try await netWork?.createUser(user: user)
            
            await netWork?.add(user: user)
            
        } catch {
            let authError = error as? AuthError
            guard let authError else { return }
            presenter?.present(errorText: authError.errorMessege)
        }
    }
    
    func sighIn(email: String?, password: String?) async {
        do {
            try await netWork?.sighIn(email: email, password: password)
        } catch {
            let authError = error as? AuthError
            guard let authError else { return }
            presenter?.present(errorText: authError.errorMessege)
        }
    }
}
