//
//  PokeHomeViewControllerTest.swift
//  PokeAppTests
//
//  Created by Christian Castro on 07/09/22.
//

import XCTest
@testable import PokeApp

class PokeHomeViewControllerTest: XCTestCase {
    var sut: PokeHomeViewController!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        sut = PokeHomeViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    class PokeInteractorSpy: PokeInteratorProtocol {
        var didCallMainPoke = false
        var didCallPostPoke = false
        
        func getMainPoke(name: String?, id: Int?) {
            didCallMainPoke = true
        }
        
        func postPoke(poke: PokeModel) {
            didCallPostPoke = true
        }
    }
    
    func testShouldDoWhenViewIsLoaded() {
        let spy = PokeInteractorSpy()
        sut.interactor = spy
        
        /// searching by id
        sut.interactor?.getMainPoke(name: "pikachu", id: nil)
        
        /// searching by name
        sut.interactor?.getMainPoke(name: nil, id: 30)
        
        /// post to webhook
        sut.interactor?.postPoke(poke: PokeModel(abilities: nil, baseExperience: nil, forms: nil, gameIndices: nil, height: nil, heldItems: nil, id: nil, isDefault: nil, locationAreaEncounters: nil, moves: nil, name: nil, order: nil, species: nil, sprites: nil, stats: nil, types: nil, weight: nil))
        
        loadView()
        
        XCTAssertTrue(spy.didCallMainPoke, "VC should ask interactor for mainPoke")
        XCTAssertTrue(spy.didCallPostPoke, "VC should ask interactor for post")
    }
}
