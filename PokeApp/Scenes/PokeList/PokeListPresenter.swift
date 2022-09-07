//
//  PokeListPresenter.swift
//  PokeApp
//
//  Created by Christian Castro on 05/09/22.
//

import Foundation

protocol PokeListPresenterProtocol {
    func presentError(error: String)
    func presentPokeList(pokes: [PokeCellModel]?)
    func presentLoading(showLoading: Bool)
}

class PokeListPresenter: PokeListPresenterProtocol {
    weak var viewController: PokeListViewControllerProtocol?
    
    func presentError(error: String) {
        self.viewController?.showError(error: error)
    }
    
    func presentPokeList(pokes: [PokeCellModel]?) {
        self.viewController?.showPokeList(pokes: pokes)
    }
    
    func presentLoading(showLoading: Bool) {
        self.viewController?.showLoading(showLoading)
    }
}
