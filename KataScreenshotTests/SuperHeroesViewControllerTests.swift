//
//  SuperHeroesViewControllerTests.swift
//  KataSuperHeroes
//
//  Created by Sergio Gutiérrez on 22/12/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import UIKit
@testable import KataScreenshot

class SuperHeroesViewControllerTests: ScreenshotTest {

    fileprivate let repository = MockSuperHeroesRepository()

    func testShowsEmptyCase() {
        givenThereAreNoSuperHeroes()

        let viewController = getSuperHeroViewController()

        verify(viewController: viewController)
    }
    
    
    func test_there_are_some_super_heroes() {
        
        _ = givenThereAreSomeSuperHeroes()
        
        let viewController = getSuperHeroViewController()
        
        verify(viewController: viewController)
    
        
    }
    
    
    func test_shows_an_avenger() {
        
        //Given
        
        _ = givenThereAreSomeSuperHeroes(1, avengers: true)
        
        //When
        let viewController = getSuperHeroViewController()
        
        //Then
        verify(viewController: viewController)
        
        
    }
    
    func test_shows_a_regular_super_hero(){
        
        //Given
        
        _ = givenThereAreSomeSuperHeroes(1, avengers: false)
        
        //When
        let viewController = getSuperHeroViewController()
        
        //Then
        verify(viewController: viewController)
        
        
    }
    
    
    
    

    fileprivate func givenThereAreSomeAvengers() -> [SuperHero] {
        return givenThereAreSomeSuperHeroes(avengers: true)
    }

    fileprivate func givenThereAreNoSuperHeroes() {
        _ = givenThereAreSomeSuperHeroes(0)
    }

    fileprivate func givenThereAreSomeSuperHeroes(_ numberOfSuperHeroes: Int = 10,
        avengers: Bool = false) -> [SuperHero] {
        var superHeroes = [SuperHero]()
        for i in 0..<numberOfSuperHeroes {
            let superHero = SuperHero(name: "SuperHero - \(i)",
                photo: URL(string: ""),
                isAvenger: avengers, description: "Description - \(i)")
            superHeroes.append(superHero)
        }
        repository.superHeroes = superHeroes
        return superHeroes
    }

    fileprivate func getSuperHeroViewController() -> UIViewController {
        let superHeroesViewController = ServiceLocator()
            .provideSuperHeroesViewController() as! SuperHeroesViewController
        superHeroesViewController.presenter = SuperHeroesPresenter(
            ui: superHeroesViewController,
            getSuperHeroes: GetSuperHeroes(repository: repository)
        )

        let rootViewController = UINavigationController()
        rootViewController.viewControllers = [superHeroesViewController]

        return rootViewController
    }
}
