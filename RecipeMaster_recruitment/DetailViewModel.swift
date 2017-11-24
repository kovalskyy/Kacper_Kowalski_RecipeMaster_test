//
//  DetailViewModel.swift
//  RecipeMaster_recruitment
//
//  Created by Moodup on 22.11.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import Foundation
import RxSwift

protocol RecipeProtocol: NSObjectProtocol {
    func onError(error: Error)
    func onCompleted(recipe: Recipe)
}

class DetailViewModel {
    
    let disposeBag = DisposeBag()
    private var apiManager: ApiManager?
    private var recipe: Recipe?
    
    weak var delegate: RecipeProtocol?
    
    init(apiManager: ApiManager) {
        self.apiManager = apiManager
    }
    
    func getRecipe() {
        self.apiManager?.getRecipe().subscribe(onNext: { (pizza) in
            self.recipe = pizza
        }, onError: { (error) in
            self.delegate?.onError(error: error)
        }, onCompleted: {
            guard let pizza = self.recipe else { return }
            self.delegate?.onCompleted(recipe: pizza)
        }).disposed(by: self.disposeBag)
    }
    
    func parseRecipe(_ item: [String]) -> [String] {
        return [item.map{" - \($0)"}.joined(separator: "\n")]
    }
    
    func parseRecipeList(_ item: [String]) -> [String] {
        return [item.enumerated().map{"\($0+1). \($1)"}.joined(separator: "\n")]
    }
}


