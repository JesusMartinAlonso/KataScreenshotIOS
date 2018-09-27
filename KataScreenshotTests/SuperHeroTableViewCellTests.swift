//
//  SuperHeroTableViewCellTests.swift
//  KataScreenshot
//
//  Created by Sergio Gutiérrez on 09/01/17.
//  Copyright © 2017 Karumi. All rights reserved.
//

import UIKit
import XCTest
@testable import KataScreenshot

class SuperHeroTableViewCellTests: ScreenshotTest {

    
    func testShowsAnySuperHero(){
        
        let superHero = givenThereIsASuperHero(name: "SuperHero")
        
        let cell = givenASuperHeroTableViewCell()
        
        cell.configure(forItem: superHero)
        
        verify(view: cell)
    }
    
    func test_shows_an_avenger(){
        let superHero = givenThereIsASuperHero(name: "SuperHero", isAvenger : true)
        
        let cell = givenASuperHeroTableViewCell()
        
        cell.configure(forItem: superHero)
        
        verify(view: cell)
    }
    
    func test_shows_superheroe_with_long_name(){
        let superHero = givenThereIsASuperHero(name: "SuperHero with a very long long long name")
        
        let cell = givenASuperHeroTableViewCell()
        
        cell.configure(forItem: superHero)
        
        verify(view: cell)
    
    }
    
    
    private func givenASuperHeroTableViewCell() -> SuperHeroTableViewCell {
        return UINib(nibName: "SuperHeroTableViewCell", bundle: Bundle.main).instantiate(withOwner: self, options: nil)[0] as! SuperHeroTableViewCell
    }
    
    
    private func givenThereIsASuperHero(name : String, image : String = "",  isAvenger : Bool = false) -> SuperHero {
        
        return SuperHero(name: name, photo: URL(string: image), isAvenger: isAvenger, description: "")
        
    }
}
