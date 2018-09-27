//
//  MockSuperHeroesRepository.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 13/01/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation
@testable import KataScreenshot

class MockSuperHeroesRepository: SuperHeroesRepository {

    var superHeroes = [SuperHero]()

    var error : SuperHeroesRepositoryError? = nil
    
    
    override func getAll(_ completion: @escaping ([SuperHero]) -> ()) {
        completion(superHeroes)
    }

 
    override func getSuperHero(withName name: String, success: @escaping (SuperHero) -> (), failure: @escaping (SuperHeroesRepositoryError) -> ()) {
        
        if let errorUnwrapped = error {
            failure(errorUnwrapped)
        }else{
            let superHeroByName = superHeroes.filter { $0.name == name }.first
            success(superHeroByName!)
        }
        
        
    }

}
