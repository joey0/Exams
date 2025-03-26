//
//  DHMainViewModel.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import Foundation

class DHMainViewModel: DHViewModel<DHMainView> {
    
    var heroList: DHHeroList = DHHeroList() {
        didSet {
            self.view.cvList.reloadData()
        }
    }
    
    override func setupRequests() {
        super.setupRequests()
        
        let heroList = DHShared.coreData.getSavedHeroList()
        if let model = heroList?.model {
            self.heroList = model
            print("used saved data")
        }
        self.fetchHeroList()
    }
    
    func fetchHeroList(completion: (() -> Void)? = nil) {
        self.service.heroService.heroList { result in
            switch result {
            case .success(let response):
                self.heroList = response
                DHShared.coreData.saveHeroList(with: self.heroList)
            case .failure(let error):
                print("error: \(error)")
            }
            completion?()
        }
    }
}
