//
//  PokeRepository.swift
//  PokeApp
//
//  Created by Christian Castro on 05/09/22.
//

import UIKit

class PokeRepository {
    private static let baseURL = "https://pokeapi.co/api/v2/"
    
    static func searchPokeByID(id: Int, success: @escaping (PokeModel, UIImage) -> Void, failure: @escaping (Error) -> Void) {
        guard let url = URL(string: baseURL + "pokemon/" + String(id)) else { return }
        let t = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, let pokeModel = try? JSONDecoder().decode(PokeModel.self, from: data) else {
                if let error = error {
                    failure(error)
                }
                return
            }
            getPicture(url: pokeModel.sprites?.other?.home?.frontDefault ?? "") { image in
                success(pokeModel, image)
            } failure: { error in
                failure(error)
            }
        }
        t.resume()
    }
    
    static func searchPokeByName(name: String, success: @escaping (PokeModel, UIImage) -> Void, failure: @escaping (String) -> Void) {
        guard let url = URL(string: baseURL + "pokemon/" + name) else { return }
        let t = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    failure(error.localizedDescription)
                }
                return
            }
            if let pokeModel = try? JSONDecoder().decode(PokeModel.self, from: data) {
                getPicture(url: pokeModel.sprites?.other?.home?.frontDefault ?? "") { image in
                    success(pokeModel, image)
                } failure: { error in
                    failure(error.localizedDescription)
                }
            } else {
                failure("I found a error when I try to decode")
            }
        }
        t.resume()
    }
    
    static func getPicture(url: String, success: @escaping (UIImage) -> Void, failure: @escaping (Error) -> Void) {
        guard let url = URL(string: url) else { return }
        
        let t = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, let image = UIImage(data: data) else {
                if let error = error {
                    failure(error)
                }
                return
            }
            success(image)
        }
        t.resume()
    }
}
