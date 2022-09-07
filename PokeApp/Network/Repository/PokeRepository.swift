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
    private static let webhookAddress = "https://webhook.site/9b896056-bede-43e8-b223-a5cffb7e9e8c"
    
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
    
    static func postRequest(with data: PokeModel, completion: @escaping (Bool) -> Void, failure: @escaping (String) -> Void) {
        guard let url = URL(string: webhookAddress), let data = try? JSONEncoder().encode(data) else { return }
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.httpBody = data
        
        // In this case, I do not need to know the data. This request will not return anything to me, according the doc
        let d = URLSession.shared.dataTask(with: urlRequest) { _, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                failure(error?.localizedDescription ?? "Error")
                return
            }
            completion(httpResponse.statusCode == 200)
        }
        d.resume()
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
                failure("Sorry, we searched for ➡️ " + (name ?? "") + " ⬅️ and we didn't find anything")
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
