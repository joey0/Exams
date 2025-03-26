//
//  DHMainCell.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import UIKit
import SnapKit

class DHMainCell: UICollectionViewCell {
    static let identifier: String = "DHMainCell"
    
    static let duration: Double = 1.0
    let colorOne: CGColor = UIColor.clear.cgColor
    let colorTwo: CGColor = UIColor.gray.withAlphaComponent(0.2).cgColor
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.colors = [self.colorOne, self.colorTwo, self.colorOne]
        gradient.locations = [0.0, 0.5, 1.0]
        return gradient
    }()
    
    var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        self.contentView.layer.cornerRadius = 15.0
        self.contentView.clipsToBounds = true
    }
    
    func setImageView(with imageView: UIImageView, url: String) {
        self.imageView = imageView
        self.imageView?.contentMode = .scaleAspectFill
        self.imageView?.clipsToBounds = true
        guard let imageView = self.imageView else {
            return
        }
        self.contentView.addSubview(imageView)
        imageView.snp.updateConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        self.startAnimating()
        DispatchQueue.global(qos: .background).async {
            DHShared.fetch.fetchHeroImage(with: url) { result in
                switch result {
                case .success(let image):
                    self.imageView?.image = image
                case .failure:
                    self.imageView?.image = DHUI.Image.main
                }
                self.removeLayer()
            }
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView?.snp.removeConstraints()
        self.imageView?.removeFromSuperview()
        self.imageView = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addLayer() {
        self.gradient.frame = self.bounds
        self.layer.addSublayer(self.gradient)
    }
    
    func removeLayer() {
        self.gradient.removeFromSuperlayer()
    }
    
    func addAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = DHMainCell.duration
        return animation
    }
    
    func startAnimating() {
        self.addLayer()
        let animation = self.addAnimation()
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.removeLayer()
        }
        self.gradient.add(animation, forKey: animation.keyPath)
        CATransaction.commit()
    }
}
