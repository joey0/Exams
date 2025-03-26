//
//  DHHeroDetailVC.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import Foundation
import UIKit

class DHHeroDetailVC: DHVCWithViewModelAndModel<DHHeroDetailViewModel, DHHeroDetailModel> {

    var heroModel: DHHeroModel?
    
    override func setupViewModel(_ viewModel: DHHeroDetailViewModel? = nil) {
        super.setupViewModel(viewModel ?? DHHeroDetailViewModel(
            parentView: self.view
        ))
    }

    override func didSetViewModel() {
        super.didSetViewModel()
        
        self.model = DHHeroDetailModel()
        
        self.viewModel.setup(with: self.heroModel)
        
        self.viewModel.view.tbMain.delegate = self
        self.viewModel.view.tbMain.dataSource = self
        self.viewModel.view.tbMain.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.view.setBanner()
    }
}

extension DHHeroDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.heroInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier: String = "hero_detail_cell"
        let cell = tableView.dequeueReusableCell(
            withIdentifier: identifier
        ) ?? UITableViewCell(style: .value2, reuseIdentifier: identifier)
        
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15.0, bottom: 0, right: 15)
        
        guard let heroInfo = self.viewModel.heroInfo[safe: indexPath.row] else {
            return cell
        }
        let titleText = heroInfo.title
        let detailText = heroInfo.detail
        
        let font = UIFont.boldSystemFont(ofSize: 16)
        
        if #available(iOS 14.0, *) {
            var config = cell.defaultContentConfiguration()
            config.attributedText = NSAttributedString(
                string: titleText,
                attributes: [.font: font]
            )
            config.secondaryAttributedText = NSAttributedString(
                string: detailText,
                attributes: [.font: font]
            )
            cell.contentConfiguration = config
        } else {
            cell.textLabel?.text = titleText
            cell.textLabel?.font = font
            
            cell.detailTextLabel?.text = detailText
            cell.detailTextLabel?.font = font
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
