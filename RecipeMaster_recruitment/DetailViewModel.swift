//
//  DetailViewModel.swift
//  RecipeMaster_recruitment
//
//  Created by Moodup on 22.11.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import Foundation

protocol RecipeProtocol: NSObjectProtocol {
    func onError(error: Error)
    func onCompleted(recipe: Recipe)
}

class DetailViewModel: BaseViewModel {
    
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
}


