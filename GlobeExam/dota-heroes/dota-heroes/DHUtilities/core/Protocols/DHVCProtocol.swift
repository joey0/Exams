//
//  DHVCProtocol.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import UIKit

protocol DHVCProtocol {
    var rootUI: UIView {
        get
    }
    func cancelAllServices()
}
