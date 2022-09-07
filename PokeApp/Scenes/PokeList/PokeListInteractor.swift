//
//  PokeListInteractor.swift
//  PokeApp
//
//  Created by Christian Castro on 05/09/22.
//

import Foundation

protocol PokeListInteractorProtocol {
    func getPictures(pokes: PokeModel?)
}

class PokeListInteractor: PokeListInteractorProtocol {
    var presenter: PokeListPresenterProtocol?
    var pokeList = [PokeCellModel]()
    var pokeGenerationCount = 0
    
    func getPictures(pokes: PokeModel?) {
        var picturesToDownload: [String?] {
            return [pokes?.sprites?.versions?.generationI?.yellow?.frontDefault,
                    pokes?.sprites?.versions?.generationIi?.crystal?.frontDefault,
                    pokes?.sprites?.versions?.generationVii?.icons?.frontDefault,
                    pokes?.sprites?.versions?.generationV?.blackWhite?.frontDefault,
                    pokes?.sprites?.versions?.generationViii?.icons?.frontDefault]
        }
        
        ///for each picture address in this array, we download the picture
        for picture in picturesToDownload {
            presenter?.presentLoading(showLoading: true)
            pokeGenerationCount = pokeGenerationCount + 1
            let name = "Generation " + String(pokeGenerationCount)
            
            PokeRepository.getPicture(url: picture ?? "") { [weak self] image in
                self?.presenter?.presentLoading(showLoading: false)
                self?.pokeList.append(PokeCellModel(description: name, contentImage: image))
                
                self?.presenter?.presentPokeList(pokes: self?.pokeList)
            } failure: { [weak self] error in
                self?.presenter?.presentLoading(showLoading: false)
                self?.presenter?.presentError(error: error)
            }
        }
    }
}
