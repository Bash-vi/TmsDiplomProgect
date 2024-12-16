//
//  List.swift
//  AnyList
//
//  Created by Вячеслав Башур on 15/12/2024.
//

import Foundation

struct Element: Identifiable, Codable {
    var id: String = UUID().uuidString
    let price: String
    var name: String
}

struct List: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
}
