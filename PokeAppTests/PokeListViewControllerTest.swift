//
//  PokeListViewControllerTest.swift
//  PokeAppTests
//
//  Created by Christian Castro on 07/09/22.
//

import XCTest
@testable import PokeApp

class PokeListViewControllerTest: XCTestCase {
    var sut: PokeListViewController!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        sut = PokeListViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    class PokeListInteractorSpy: PokeListInteractorProtocol {
        var didCallPictureDetail = false
        
        func getPictureDetail(pokes: [PokeCellModel]?) {
            didCallPictureDetail = true
        }
    }
    
    func testShouldDoWhenViewIsLoaded() {
        let spy = PokeListInteractorSpy()
        sut.interactor = spy
        
        sut.interactor?.getPictureDetail(pokes: nil)
        
        loadView()
        
        XCTAssertTrue(spy.didCallPictureDetail, "VC should ask interactor for mainPoke")
    }
}
