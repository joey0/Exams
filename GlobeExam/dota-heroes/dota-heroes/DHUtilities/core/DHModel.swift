//
//  DHModel.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import Foundation

public protocol DHModel {
    var title: String? { get }
}

// Optionals
//
extension DHModel {
    public var title: String? {
        get { return nil }
        set { _ = newValue }
    }
}
