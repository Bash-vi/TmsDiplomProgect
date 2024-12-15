//
//  Network.swift
//  AnyList
//
//  Created by Вячеслав Башур on 15/12/2024.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

protocol AuthProtocol {
    func createUser(user: User) async throws
}

enum AuthError: Error {
    case wrongLoginOrPassword
    
    var errorMessege: String {
        return switch self {
        case .wrongLoginOrPassword: "неправильный"
        }
    }
}

class NetWork: AuthProtocol {
    func createUser(user: User) async throws {
        
        guard let email = user.email, !email.isEmpty else { throw AuthError.wrongLoginOrPassword }
        guard let password = user.password, !password.isEmpty else { throw AuthError.wrongLoginOrPassword }
        _ = try await Auth.auth().createUser(withEmail: email, password: password)
//            try await result.user.sendEmailVerification()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userUidData: User = .init(id: uid, email: user.email, password: nil, name: user.name, surename: user.surename)
            try Firestore.firestore()
                .collection("users")
                .document(userUidData.id)
                .setData(from: userUidData)
            signOut()
    }
    
//    func sighIn(email: String, password: String) async -> Result<User, AuthError> {
//        do {
//            _ = try await Auth.auth().signIn(withEmail: email, password: password)
//           
//            return await .success(getUserData())
//        } catch {
//            return .failure(.wrongLoginOrPassword)
//        }
//    }
    
//    func getUserData() async -> User {
//        do {
//            guard let uid = Auth.auth().currentUser?.uid else {return User()}
//            let snapShot = try await Firestore.firestore().collection("users").document(uid).getDocument()
//            
//            let userData = try snapShot.data(as: User.self)
//            return userData
//        } catch {
//            return User()
//        }
//    }
    
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
