//
//  PokeRepository.swift
//  PokeApp
//
//  Created by Christian Castro on 05/09/22.
//

import UIKit

class PokeRepository {
    private static let baseURL = "https://pokeapi.co/api/v2/"
    private static let pokemonURLComponent = "pokemon/"
    
    private static func request(to url: String, completion: @escaping (Data) -> Void, failure: @escaping (String) -> Void) {
        guard let url = URL(string: url.contains("https://raw.githubusercontent.com") ? url : baseURL + url) else { return }
        let t = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                failure(error?.localizedDescription ?? "Error")
                return
            }
            completion(data)
        }
        t.resume()
    }
    
    static func searchPokeByID(id: Int, success: @escaping (PokeModel, UIImage) -> Void, failure: @escaping (String) -> Void) {
        request(to: pokemonURLComponent + String(id)) { data in
            if let pokeModel = try? JSONDecoder().decode(PokeModel.self, from: data) {
                getPicture(url: pokeModel.sprites?.other?.home?.frontDefault ?? "") { image in
                    success(pokeModel, image)
                } failure: { error in
                    failure(error)
                }
            } else {
                failure("I found a error when I tried collect the poke information")
            }
        } failure: { error in
            failure(error)
        }
    }
    
    static func searchPokeByName(name: String?, id: Int?, success: @escaping (PokeModel, UIImage) -> Void, failure: @escaping (String) -> Void) {
        var url: String?
        if let name = name {
            url = pokemonURLComponent + name
        } else if let id = id {
            url = pokemonURLComponent + String(id)
        }
        request(to: url ?? "") { data in
            if let pokeModel = try? JSONDecoder().decode(PokeModel.self, from: data) {
                getPicture(url: pokeModel.sprites?.other?.home?.frontDefault ?? "") { image in
                    success(pokeModel, image)
                } failure: { error in
                    failure(error)
                }
            } else {
                failure("I found a error when I tried collect the poke information")
            }
        } failure: { error in
            failure(error)
        }
    }
    
    static func getPicture(url: String, success: @escaping (UIImage) -> Void, failure: @escaping (String) -> Void) {
        request(to: url) { data in
            guard let image = UIImage(data: data) else {
                failure("Unable to create UIImage with Data")
                return
            }
            success(image)
        } failure: { error in
            failure(error)
        }
    }
}
