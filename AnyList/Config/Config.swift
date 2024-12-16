//
//  Config.swift
//  AnyList
//
//  Created by Вячеслав Башур on 13/12/2024.
//

import Foundation

enum Config {
    static let spacing: CGFloat = 10
    static let titleLabelWidth: CGFloat = 150
    static let buttonSize: CGFloat = 40
    static let userIconSize: CGFloat = 60
    static let listIconSize: CGFloat = 180
    
    enum Cell {
        static let indent: CGFloat = 15
    }
    
    enum Indent {
        static let bot: CGFloat = -20
        static let right: CGFloat = -30
        static let top: CGFloat = 20
        static let left: CGFloat = 30
    }
}
