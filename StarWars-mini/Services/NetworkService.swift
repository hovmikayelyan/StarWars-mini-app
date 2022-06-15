//
//  NetworkService.swift
//  StarWars-mini
//
//  Created by Hovhannes Mikayelyan on 6/15/22.
//  Copyright © 2022 Hovhannes Mikayelyan. All rights reserved.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    let URL_CHARACTERS = "https://swapi.dev/api/people/?page="
    let session = URLSession(configuration: .default)
    
    func getCharactersByPage(page: Int, onSuccess: @escaping (Characters)->Void, onError: @escaping (String)->Void) {
        let url = URL(string: "\(URL_CHARACTERS)\(page)")!
        
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print(error)
                onError(error.localizedDescription)
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                onError("Invalid data or response")
                return
            }
            
            do {
                if response.statusCode == 200 {
                    let characters = try JSONDecoder().decode(Characters.self, from: data)
                    onSuccess(characters)
                } else {
                    let err = try JSONDecoder().decode(APIError.self, from: data)
                    onError(err.message)
                }
            } catch {
                print(error)
                onError(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func getPlanet(URL_PLANET: String, onSuccess: @escaping (Planet)->Void, onError: @escaping (String)->Void) {
        let url = URL(string: URL_PLANET)!
        
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let planet = try JSONDecoder().decode(Planet.self, from: data)
                        onSuccess(planet)
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError(err.message)
                    }
                } catch {
                    print(error)
                    onError(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
    
}
