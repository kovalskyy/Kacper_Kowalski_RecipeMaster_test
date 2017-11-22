//
//  APiManager.swift
//  RecipeMaster_recruitment
//
//  Created by Moodup on 22.11.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import AlamofireObjectMapper

class ApiManager: ApiProtocol {
    
    func getRecipe() -> Observable<Recipe> {
        let url = URL(string: endPoint)!
        
        return Observable.create({ observable in
            let request = Alamofire.request(url,
                                            method: .get,
                                            parameters: nil,
                                            encoding: URLEncoding.default,
                                            headers: nil)
                .responseObject(completionHandler: { (response: DataResponse<Recipe>) in
                    if response.response?.statusCode == 200 && response.result.isSuccess {
                        guard let recipe = response.result.value else { return }
                        observable.onNext(recipe)
                        observable.onCompleted()
                    } else {
                        guard let error = response.error else { return }
                        observable.onError(error)
                    }
                })
            return Disposables.create {
                request.cancel()
            }
        })
   
    }
}
