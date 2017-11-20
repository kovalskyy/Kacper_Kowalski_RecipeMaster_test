//
//  Service.swift
//  RecipeMaster_recruitment
//
//  Created by Moodup on 20.11.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import Foundation

struct RecipeService: Gettable {
    
    let downloader = NetworManager()

    typealias currentRecipeCompletionHandler = (Result<RecipeModel?>) -> ()

    func get(completion: @escaping currentRecipeCompletionHandler) {

        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidURL))
            return
        }

        let request = URLRequest(url: url)
        let task = downloader.jsonTask(with: request) { (result) in

            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                    return
                case .success(let json):
                    let recipe = RecipeModel(json: json)
                    completion(.success(recipe))
                }
            }
        }
        task.resume()
    }
}

protocol Gettable {
    associatedtype T
    func get(completion: @escaping (Result<T>) -> Void)
}

