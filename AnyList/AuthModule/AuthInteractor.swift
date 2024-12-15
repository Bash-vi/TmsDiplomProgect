//
//  AuthInteractor.swift
//  AnyList
//
//  Created by Вячеслав Башур on 15/12/2024.
//

import Foundation

protocol AuthInteractorProtocol {
    func register(user: User) async
}

class AuthInteractor: AuthInteractorProtocol {
    weak var presenter: AuthPresenterResultHandler?
    
    let network: NetWork = .init()
    
    func register(user: User) async {
        do {
            try await network.createUser(user: user)
        } catch {
            let err = error as! AuthError
            print(err)
            presenter?.present(errorText: err.errorMessege)
            
        }
    }
}
