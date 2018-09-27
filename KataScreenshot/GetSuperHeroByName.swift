//
//  GetSuperHeroByName.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 12/01/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation

class GetSuperHeroByName {

    fileprivate let repository: SuperHeroesRepository

    init(repository: SuperHeroesRepository) {
        self.repository = repository
    }

    func execute(_ superHeroName: String, success: @escaping (SuperHero) -> (), failure: @escaping (SuperHeroesRepositoryError) -> ()  ) {
  
        repository.getSuperHero(withName: superHeroName, success: { (superHero) in
            success(superHero)
        }) { (error) in
            failure(error)
        }
    }

}
