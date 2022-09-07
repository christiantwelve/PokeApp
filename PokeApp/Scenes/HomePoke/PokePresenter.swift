//
//  PokePresenter.swift
//  PokeApp
//
//  Created by Christian Castro on 04/09/22.
//

import Foundation
import UIKit

protocol PokePresenterProtocol {
    func presentPoke(poke: PokeModel, image: UIImage)
    func presentFavorite(success: Bool)
    func presentError(error: String)
    func presentLoading(showLoading: Bool)
}

class PokePresenter: PokePresenterProtocol {
    weak var viewController: PokeHomeViewControllerProtocol?
    
    func presentPoke(poke: PokeModel, image: UIImage) {
        viewController?.showPoke(poke: poke, image: image)
    }
    
    func presentError(error: String) {
        viewController?.showError(error: error)
    }
    
    func presentLoading(showLoading: Bool) {
        viewController?.showLoading(showLoading)
    }
    
    func presentFavorite(success: Bool) {
        viewController?.showFavorite(success: success)
    }
}
