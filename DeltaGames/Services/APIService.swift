//
//  APIService.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 02/10/21.
//

import Foundation

class APIService {
    
    let baseURL: String = "https://api.rawg.io/api/"
    let key: String = "6e74f6ad560347d2b34764aa1ea63362"
    
    func getNewAndTrending(order: String, discover: String, completion: @escaping (Result<Results, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)games/lists/main?key=\(key)&ordering=\(order)&discover=\(discover)") else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                DispatchQueue.main.async {
                    print("Client error!")
                    completion(.failure(error!))
                }
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            guard let data = data else { return }
            do {
                let decodedResponse = try JSONDecoder().decode(Results.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedResponse))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getListAllGame(completion: @escaping (Result<Results, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)games?key=\(key)") else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                completion(.failure(error!))
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            guard let data = data else { return }
            do {
                let decodedResponse = try JSONDecoder().decode(Results.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedResponse))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    func getDetailGame(gameID: Int, completion: @escaping (Result<Game, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)games/\(gameID)?key=\(key)") else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                completion(.failure(error!))
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            guard let data = data else { return }
            do {
                let decodedResponse = try JSONDecoder().decode(Game.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedResponse))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    func getSearchGame(search: String, completion: @escaping (Result<Results, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)games?search='\(search)'&key=\(key)") else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                completion(.failure(error!))
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            guard let data = data else { return }
            do {
                let decodedResponse = try JSONDecoder().decode(Results.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedResponse))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
