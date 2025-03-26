//
//  DHView.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//
import UIKit

extension UIView {
    
    func subview(forAutoLayout subview: UIView) {
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func subviews(forAutoLayout subviews: UIView...) {
        self.subviews(forAutoLayout: subviews)
    }
    
    func subviews(forAutoLayout subviews: [UIView]) {
        subviews.forEach(self.subview)
    }
    
    func subviews(forAutoLayout subviews: [UIView], completion: (UIView) -> Void) {
        subviews.forEach(completion)
    }
    
    func subviews(forRemoval subviews: [UIView]) {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    func subviews(forQuery query: (UIView) throws -> Bool) -> [UIView] {
        guard let result: [UIView] = try? self.allSubviews().filter(query) else {
            return []
        }
        return result
    }
    
    func allSubviews() -> [UIView] {
        var descendants: [UIView] = []
        descendants.append(self)
        self.subviews.forEach {
            descendants.append(
                contentsOf: $0.subviews
            )
        }
        return descendants
    }
    
    var contained: UIView {
        let container = UIView()
        container.addSubview(self)
        container.frame.size = self.frame.size
        return container
    }
    
    var snapshot: UIImage {
        return UIGraphicsImageRenderer(size: self.bounds.size).image { _ in
            drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
    }
}
