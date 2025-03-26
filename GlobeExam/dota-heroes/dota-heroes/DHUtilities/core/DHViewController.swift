//
//  DHViewController.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import UIKit

class DHViewController: UIViewController {
    
    private(set) var screen: DHScreen?
    
    open func didDisplay(screen: DHScreen?) {
        #if DEBUG
        print(self.screen?.name ?? "")
        print(self.screen?.className ?? "")
        #endif
    }
}
