//
//  User.swift
//  AnyList
//
//  Created by Вячеслав Башур on 14/12/2024.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String = UUID().uuidString
    let email: String
    let password: String
    var name: String
    var surename: String? = nil
    var fullName: String {
        "\(name) \(surename ?? "")"
    }
}
