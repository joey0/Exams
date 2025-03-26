//
//  ViewController.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import UIKit

class DHMainVC: DHVCWithViewModelAndModel<DHMainViewModel, DHMainModel> {

    override func setupViewModel(_ viewModel: DHMainViewModel? = nil) {
        super.setupViewModel(viewModel ?? DHMainViewModel(
            parentView: self.view
        ))
    }

    override func didSetViewModel() {
        super.didSetViewModel()
        
        self.model = DHMainModel()
        
        self.navigationItem.leftBarButtonItems = [
            UIBarButtonItem(customView: self.viewModel.view.imTitle),
            UIBarButtonItem(customView: self.viewModel.view.lbTitle)
        ]
        
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: {
                let button = UIButton()
                button.setImage(DHUI.Image.refresh, for: .normal)
                button.addTarget(self, action: #selector(didSelectRefresh(_:)), for: .touchUpInside)
                return button
            }())
        ]
        
        self.viewModel.view.cvList.delegate = self
        self.viewModel.view.cvList.dataSource = self
        self.viewModel.view.cvList.reloadData()
    }
    
    @objc func didSelectRefresh(_ button: UIButton) {
        let rotate: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotate.toValue = NSNumber(value: Double.pi * 2)
        rotate.duration = 1
        rotate.isCumulative = true
        rotate.repeatCount = .infinity
        button.layer.add(rotate, forKey: "rotation")
        self.viewModel.fetchHeroList {
            button.layer.removeAnimation(forKey: "rotation")
        }
    }
}

extension DHMainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return DHHeroList.PRIMARY_ATTR.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let attr = DHHeroList.PRIMARY_ATTR.allCases[section]
        let count = self.viewModel.heroList.getList(with: attr).count
        return count == 0 ? 5 : count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DHMainCell.identifier,
            for: indexPath
        ) as! DHMainCell
        let attr = DHHeroList.PRIMARY_ATTR.allCases[indexPath.section]
        let list = self.viewModel.heroList.getList(with: attr)
        if list.count == 0 {
            cell.startAnimating()
        } else {
            cell.removeLayer()
        }
        if let img = list[safe: indexPath.row]?.img {
            cell.setImageView(with: UIImageView(), url: img)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: DHMainSection.identifier,
                for: indexPath
            ) as! DHMainSection
            let attr = DHHeroList.PRIMARY_ATTR.allCases[indexPath.section]
            sectionHeader.lbTitle.text = "\(attr)".uppercased()
            sectionHeader.lbTitle.textColor = attr.color
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: 0.3) {
            cell?.alpha = 0.1
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                cell?.alpha = 1.0
            } completion: { _ in
                let attr = DHHeroList.PRIMARY_ATTR.allCases[indexPath.section]
                let list = self.viewModel.heroList.getList(with: attr)
                guard let heroModel = list[safe: indexPath.row] else {
                    return
                }
                self.navigate(to: DHRoute.heroDetail(heroModel: heroModel), with: .push)
            }
        }
    }
}
