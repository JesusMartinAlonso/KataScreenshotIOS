//
//  SuperHeroDetailViewControllerTests.swift
//  KataScreenshotTests
//
//  Created by Jesus Martin Alonso on 27/9/18.
//  Copyright © 2018 Karumi. All rights reserved.
//

import XCTest
@testable import KataScreenshot

class SuperHeroDetailViewControllerTests: ScreenshotTest {
    
    
    fileprivate let repository = MockSuperHeroesRepository()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func test_regular_super_hero() {
        
        _ = givenThereIsASuperHeroWithName("SuperHero", isAvenger: false)
        
        let viewController = getSuperHeroViewControllerWithName("SuperHero")
        
        verify(viewController: viewController)
    }
    
    
    func test_avenger_super_hero(){
        
        _ = givenThereIsASuperHeroWithName("SuperHero", isAvenger: true)
        
        let viewController = getSuperHeroViewControllerWithName("SuperHero")
        
        verify(viewController: viewController)
    }
    
    
    func test_regular_super_hero_with_long_name(){
        _ = givenThereIsASuperHeroWithLongName()
        
        let veryLongName = "Superhero with very long long long long long long long long name "
        
        let viewController = getSuperHeroViewControllerWithName(veryLongName)
        
        verify(viewController: viewController)
        
    }
    
    
    func test_internet_connection_error(){
        
        _ = givenThereIsNotInternetConnection()
        
        let viewController = getSuperHeroViewControllerWithName("SuperHero")
        
        verify(viewController: viewController)
        
        
    }
    
    
    func test_superhero_does_not_exist(){
        
        _ = givenSuperHeroDoesNotExists()
        
        let viewController = getSuperHeroViewControllerWithName("SuperHero")
        
        verify(viewController: viewController)
        
        
    }
    
    
    
    
    
    
    fileprivate func givenThereIsNotInternetConnection(){
        repository.error = .NoInternetConnection
    }
    
    fileprivate func givenSuperHeroDoesNotExists(){
        repository.error = .SuperHeroNotFound
    }
    
    fileprivate func givenThereIsASuperHeroWithEmptyName() -> SuperHero {
        return givenThereIsASuperHeroWithName("", isAvenger: false)
    }
    
    fileprivate func givenThereIsASuperHeroWithLongName() -> SuperHero {
        return givenThereIsASuperHeroWithName("Superhero with very long long long long long long long long name ", isAvenger: false)
        
    }
    
    
    fileprivate func givenThereIsASuperHeroWithName(_ name : String, isAvenger : Bool) -> SuperHero{
        let superHero = SuperHero(name: name,
                                  photo: URL(string: ""),
                                  isAvenger: isAvenger, description: "Description")
        repository.superHeroes = [superHero]
        return superHero
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

    
    
    fileprivate func getSuperHeroViewControllerWithName(_ name : String) -> UIViewController {
        let superHeroeDetailViewController = ServiceLocator().provideSuperHeroDetailViewController(name) as! SuperHeroDetailViewController
        
        superHeroeDetailViewController.presenter = SuperHeroDetailPresenter(ui: superHeroeDetailViewController, superHeroName: name, getSuperHeroByName: GetSuperHeroByName(repository: repository))
        
        let rootViewController = UINavigationController()
        rootViewController.viewControllers = [superHeroeDetailViewController]
        return rootViewController
    }
    
    
 
    
}
