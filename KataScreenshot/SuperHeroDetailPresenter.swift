//
//  SuperHeroDetailPresenter.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 12/01/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation
import BothamUI

class SuperHeroDetailPresenter: BothamPresenter {

    fileprivate weak var ui: SuperHeroDetailUI?
    fileprivate let superHeroName: String
    fileprivate let getSuperHeroByName: GetSuperHeroByName

    init(ui: SuperHeroDetailUI, superHeroName: String, getSuperHeroByName: GetSuperHeroByName) {
        self.ui = ui
        self.superHeroName = superHeroName
        self.getSuperHeroByName = getSuperHeroByName
    }

    func viewDidLoad() {
        ui?.title = superHeroName
        ui?.showLoader()
        getSuperHeroByName.execute(superHeroName, success: { (superHero) in
            self.ui?.hideLoader()
            self.ui?.show(superHero: superHero)
        }) { (error) in
            
            self.ui?.hideLoader()
            switch error {
            case .NoInternetConnection :
                
                self.ui?.showError("No hay conexión a Internet")
                
            case .SuperHeroNotFound :
                
                 self.ui?.showError("No se encuentra el superheroe")
            }
            
            
        }
        
        
    }

}

protocol SuperHeroDetailUI: BothamUI, BothamLoadingUI {

    var title: String? {get set}
    func show(superHero: SuperHero?)
    func showError(_ error : String)

}
