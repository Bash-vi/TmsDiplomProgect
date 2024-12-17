//
//  Network.swift
//  AnyList
//
//  Created by Вячеслав Башур on 15/12/2024.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

protocol NetWorkAnyListProtocol: AnyObject {
    func signOut()
    func create(list: List) async
    func create(element: Element) async
    func readLists() async -> [List]
    func readElements() async -> [Element]
    func update(listId: String, newList: List) async
    func update(elementId: String, element: Element) async
    func delete(listId: String) async
    func delete(elementId: String) async
    func getUserData() async throws -> User
}

protocol NetWorkAuthProtocol: AnyObject {
    func signOut()
    func createUser(user: User) async throws
    func sighIn(email: String?, password: String?) async throws
    func add(user: User) async
}

enum AuthError: Error {
    case emailIsEmpty
    case passwordIsEmpty
    case toShortPassword
    
    var errorMessege: String {
        return switch self {
        case .emailIsEmpty: "Поле почты не должна быть пустой"
        case .passwordIsEmpty: "Придумайте пароль"
        case .toShortPassword: "Короткий пароль, не меньше 8 символов"
        }
    }
}

enum CollectionName {
    static let users = "Users"
    static let lists = "Lists"
    static let elemets = "Elements"
}

class NetWork: NetWorkAuthProtocol, NetWorkAnyListProtocol {
    
    let minimumPasswordLength = 8
    
    let db: Firestore = Firestore.firestore()
    
    let defaultUser: User = .init(email: nil, password: nil)
    
    let collection = CollectionName.self
    
    func createUser(user: User) async throws {
        guard let email = user.email, !email.isEmpty else { throw AuthError.emailIsEmpty }
        
        guard let password = user.password, !password.isEmpty else { throw AuthError.passwordIsEmpty }
        
        guard password.count >= minimumPasswordLength else { throw AuthError.toShortPassword }
        _ = try await Auth.auth().createUser(withEmail: email, password: password)
        await add(user: user)
    }
    
    func add(user: User) async  {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userUidData: User = .init(
            id: uid, email: user.email, password: nil,  name: user.name, surename: user.surename
        )
        do {
            try db.collection(collection.users).document(userUidData.id).setData(from: userUidData)
        } catch {
            print("Error adding document: \(error)")
        }
    }
    
    
    func sighIn(email: String?, password: String?) async throws {
        guard let email, !email.isEmpty else { throw AuthError.emailIsEmpty }
        
        guard let password, !password.isEmpty else { throw AuthError.passwordIsEmpty }
        
        guard password.count >= minimumPasswordLength else { throw AuthError.toShortPassword }
        
        _ = try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func getUserData() async throws -> User {
        guard let uid = Auth.auth().currentUser?.uid else { return defaultUser }
        let snapShot = try await db.collection(collection.users).document(uid).getDocument()
        let userData = try snapShot.data(as: User.self)
        return userData
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    func isLogin() -> Bool {
        if let _ = Auth.auth().currentUser {
            return true
        } else {
            return false
        }
    }
    
    func create(list: List) async {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            try db.collection(collection.users)
                .document(uid)
                .collection(collection.lists)
                .document()
                .setData(from: list)
        } catch {
            print(error)
        }
    }
    
    func create(element: Element) async {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            try db.collection(collection.users)
                .document(uid)
                .collection("elements")
                .document()
                .setData(from: element)
        } catch {
            print(error)
        }
    }
   
    func readLists() async -> [List] {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return [] }
            let snapshot = try await db.collection(collection.users)
                .document(uid)
                .collection(collection.lists)
                .getDocuments()
            let lists: [List] = snapshot.documents.compactMap {
                var list = try! $0.data(as: List.self)
                list.id = $0.documentID
                return list
            }
            return lists
        } catch {
            print(error)
            return []
        }
    }
   
    func readElements() async -> [Element] {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return [] }
            let snapshot = try await db.collection(collection.users)
                .document(uid)
                .collection("elements")
                .getDocuments()
            let elements: [Element] = snapshot.documents.compactMap {
                var element = try! $0.data(as: Element.self)
                element.id = $0.documentID
                return element
            }
            return elements
        } catch {
            print(error)
            return []
        }
    }
    
    func update(listId: String, newList: List) async {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            try await db.collection(collection.users)
                .document(uid)
                .collection(collection.lists)
                .document(listId)
                .updateData([
                    "name": newList.name,
                ])
        } catch {
            print(error)
        }
    }
    
    func update(elementId: String, element: Element) async {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            try await db.collection("users")
                .document(uid)
                .collection("elements")
                .document(elementId)
                .updateData([
                    "name": element.name,
                    "price" : element.price
                ])
        } catch {
            print(error)
        }
    }
   
    func delete(listId: String) async {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            try await db.collection(collection.users)
                .document(uid)
                .collection(collection.lists)
                .document(listId)
                .delete()
        } catch {
            print(error)
        }
    }
    
    func delete(elementId: String) async {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            try await db.collection("users")
                .document(uid)
                .collection("elements")
                .document(elementId)
                .delete()
        } catch {
            print(error)
        }
    }
}
