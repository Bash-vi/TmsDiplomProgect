//
//  Network.swift
//  AnyList
//
//  Created by Вячеслав Башур on 15/12/2024.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

protocol NetWorkAuthProtocol: AnyObject {
    func createUser(user: User) async throws
    func sighIn(email: String?, password: String?) async throws
    func getUserData() async throws -> User
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

class NetWork: NetWorkAuthProtocol {
    
    let minimumPasswordLength = 8
    
    let db: Firestore = Firestore.firestore()
    
    let defaultUser: User = .init(email: nil, password: nil)
    
    func createUser(user: User) async throws {
        guard let email = user.email, !email.isEmpty else { throw AuthError.emailIsEmpty }
        
        guard let password = user.password, !password.isEmpty else { throw AuthError.passwordIsEmpty }
        
        guard password.count >= minimumPasswordLength else { throw AuthError.toShortPassword }
        
        _ = try await Auth.auth().createUser(withEmail: email, password: password)
//            try await result.user.sendEmailVerification()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userUidData: User = .init(id: uid, email: user.email, password: nil, name: user.name, surename: user.surename)
         add(userUidData: userUidData)
    }
    
    private func add(userUidData: User)  {
        do {
        try db
            .collection("users")
            .document(userUidData.id)
            .setData(from: userUidData)
            print(userUidData)
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
            let snapShot = try await db.collection("users").document(uid).getDocument()
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
}
