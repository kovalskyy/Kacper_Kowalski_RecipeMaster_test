//
//  SwinjectStoryboard+Setup.swift
//  RecipeMaster_recruitment
//
//  Created by Moodup on 22.11.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    class func setup() {
        
        defaultContainer.register(ApiManager.self) { _ in ApiManager()
        }
        
        // MARK: ViewController
        
        defaultContainer.storyboardInitCompleted(DetailsViewController.self) { (resolver, controller) in
            controller.detailViewModel = resolver.resolve(DetailViewModel.self)
        }
        
        // MARK: ViewModel
        
        defaultContainer.register(DetailViewModel.self) { resolver in
            DetailViewModel(apiManager: resolver.resolve(ApiManager.self)!)
        }
        
         func getAPIManager() -> ApiManager {
            return defaultContainer.resolve(ApiManager.self)!
        }
    }
}


