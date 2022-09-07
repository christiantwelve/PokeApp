//
//  PokeFactory.swift
//  PokeApp
//
//  Created by Christian Castro on 04/09/22.
//

import UIKit

class PokeFactory {
    static func getPokeHomeViewController() -> UIViewController {
        let viewController = PokeHomeViewController()
        let presenter = PokePresenter()
        let interator = PokeInteractor()
        interator.presenter = presenter
        viewController.interactor = interator
        presenter.viewController = viewController
        return viewController
    }
    
    static func getPokeListViewController(poke: PokeModel?) -> UIViewController {
        let viewController = PokeListViewController()
        let presenter = PokeListPresenter()
        let interator = PokeListInteractor()
        interator.presenter = presenter
        viewController.interactor = interator
        presenter.viewController = viewController
        
        viewController.pokeModel = poke
        
        return viewController
    }
}
