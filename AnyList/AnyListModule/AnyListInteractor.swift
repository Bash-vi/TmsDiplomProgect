//
//  AnyListInteractor.swift
//  AnyList
//
//  Created by Вячеслав Башур on 16/12/2024.
//

import Foundation

protocol AnyListInteractorProtocol {
    func Load () async
    func refresh() async
    func signOut()
}

class AnyListInteractor: AnyListInteractorProtocol {
    
    weak var presenter: AnyListPresenterResultHandler?
    
    var netWork: NetWorkAnyListProtocol?
    
    func Load () async {
        do {
            let user = try await netWork?.getUserData()
            guard let user else { return }
            presenter?.present(user: user)
        } catch {
            print(error)
        }
        
        let lists = await netWork?.readLists()
        guard let lists else { return }
        presenter?.present(lists: lists)
    }
    
    func refresh() async {
        let lists = await netWork?.readLists()
        guard let lists else { return }
        presenter?.present(lists: lists)
    }
    
    func signOut() {
        netWork?.signOut()
    }
}
