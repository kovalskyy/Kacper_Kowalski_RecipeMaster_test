//
//  NetworkManager.swift
//  RecipeMaster_recruitment
//
//  Created by Moodup on 20.11.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import Foundation

struct NetworManager {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    init() {
        self.init(configuration: .default)
    }
    
    typealias JSON = [String: AnyObject]
    typealias JSONTaskCompletionHanlder = (Result<JSON>) -> ()
    
    func jsonTask(with request: URLRequest, withCompletionHandler completion: @escaping JSONTaskCompletionHanlder) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }
            
            if httpResponse.statusCode == 200 {
                
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                            DispatchQueue.main.async {
                                completion(.success(json))
                            }
                        }
                    } catch {
                        completion(.failure(.jsonConversionFailure))
                    }
                } else {
                    completion(.failure(.invalidData))
                }
            } else {
                completion(.failure(.responseUnsuccessful))
                print("\(String(describing: error))")
            }
        }
        return task
    }
}



