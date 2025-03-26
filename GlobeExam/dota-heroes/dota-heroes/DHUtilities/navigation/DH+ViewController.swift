//
//  DH+ViewController.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import UIKit

public extension UIViewController {
    @discardableResult
    func navigate<T: DHRouteProtocol>(
        to route: T,
        from controller: UIViewController? = nil,
        with style: DHPresentStyle = .push,
        animated: Bool = true
    ) -> UIViewController {
        let viewController = route.viewController()
        return viewController?.start(
            style, controller ?? (viewController?.navigationController ?? self), animated
        ) ?? self
    }
}

extension UIViewController {
    
    func start(error: String) {
        print("\(#function) Reason: \(error)")
    }
    
    @discardableResult
    func start(
        _ presentStyle: DHPresentStyle = .push,
        _ viewController: UIViewController,
        _ animated: Bool = true
    ) -> Self {
        
        switch presentStyle {
        case .push where !(self is UINavigationController):
            if let navigationController = viewController as? UINavigationController {
                self.push(to: navigationController, animated: animated)
                return self
            }
            self.push(to: viewController.navigationController, animated: animated)
        case .present:
            viewController.present(self, animated: animated, completion: nil)
        case .root where viewController is UINavigationController:
            guard let navigationController = viewController as? UINavigationController else {
                self.start(error: "LogicalError: can't push navigationController to navigationController")
                return self
            }
            navigationController.setViewControllers([self], animated: animated)
        default:
            self.start(error: "Present style not supported")
        }
        return self
    }
}

extension UIViewController {
    
    private func push(to navigationController: UINavigationController?, animated: Bool) {
        guard let navigationController = navigationController else {
            self.start(error: "Present style not allowed")
            return
        }
        if navigationController.viewControllers.last == self {
            self.start(error: "\(self.classForCoder) already push")
            return
        }
        navigationController.pushViewController(self, animated: animated)
    }
}
