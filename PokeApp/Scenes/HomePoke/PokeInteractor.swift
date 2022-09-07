//
//  PokeInteractor.swift
//  PokeApp
//
//  Created by Christian Castro on 04/09/22.
//

import Foundation

protocol PokeInteratorProtocol {
    func getMainPoke(name: String?, id: Int?)
}

class PokeInteractor: PokeInteratorProtocol {
    var presenter: PokePresenterProtocol?
    
    func getMainPoke(name: String?, id: Int?) {
        if let name = name {
            PokeRepository.searchPokeByName(name: name, id: nil) { [weak self] response, image  in
                self?.presenter?.presentPoke(poke: response, image: image)
            } failure: { [weak self] error in
                self?.presenter?.presentError(error: error)
            }
        } else if let id = id {
            PokeRepository.searchPokeByName(name: nil, id: id) { [weak self] response, image  in
                self?.presenter?.presentPoke(poke: response, image: image)
            } failure: { [weak self] error in
                self?.presenter?.presentError(error: error)
            }
        }
    }
}
