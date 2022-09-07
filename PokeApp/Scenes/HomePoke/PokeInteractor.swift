//
//  PokeInteractor.swift
//  PokeApp
//
//  Created by Christian Castro on 04/09/22.
//

import Foundation

protocol PokeInteratorProtocol {
    func getMainPoke(name: String)
}

class PokeInteractor: PokeInteratorProtocol {
    var presenter: PokePresenterProtocol?
    
    func getMainPoke(name: String) {
        PokeRepository.searchPokeByName(name: name) { [weak self] response, image  in
            self?.presenter?.presentPoke(poke: response, image: image)
        } failure: { [weak self] error in
            self?.presenter?.presentError(error: error)
        }
    }
}
