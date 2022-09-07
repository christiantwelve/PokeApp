//
//  PokeListInteractor.swift
//  PokeApp
//
//  Created by Christian Castro on 05/09/22.
//

import Foundation

protocol PokeListInteractorProtocol {
    func getPictureDetail(pokes: [PokeCellModel]?)
}

class PokeListInteractor: PokeListInteractorProtocol {
    var presenter: PokeListPresenterProtocol?
    var pokeList: [PokeCellModel]?
    
    func getPictureDetail(pokes: [PokeCellModel]?) {
        guard let pokes = pokes else { return }
        for poke in pokes {
            PokeRepository.getPicture(url: poke.image ?? "") { image in
                
            } failure: { string in
                
            }
        }
    }
}
