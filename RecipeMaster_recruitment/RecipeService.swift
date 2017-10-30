//
//  RecipeService.swift
//  RecipeMaster_recruitment
//
//  Created by Kacper Kowalski on 27.10.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import Foundation
import Alamofire

var request: Alamofire.Request?

class Recipe {
    private var _title: String!
    private var _description: String!
    private var _ingredients: String!
    private var _preparing: String!
    private var _images: String!
    
    var title: String {
        if _title == nil {
            _title = ""
        }
        return _title
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var ingredients: String {
        if _ingredients == nil {
            _ingredients = ""
        }
        return _ingredients
    }
    
    var preparing: String {
        if _preparing == nil {
            _preparing = ""
        }
        return _preparing
    }
    
    var images: String {
        if _images == nil {
            _images = ""
        }
        return _images
    }
    
    static let endPoint = "http://mooduplabs.com/test/info.php"
    
    typealias RecipeCompletionHandler = () -> ()
    
    func fetchRecipe(_ completed: @escaping RecipeCompletionHandler) {
        
        let url = URL(string: Recipe.endPoint)!
        
        request = Alamofire.request(url).responseJSON { response in
            debugPrint(response)
            
            DispatchQueue.global().async {
                
                if let dict = response.result.value as? Dictionary <String, AnyObject> {
                    
                    if let title = dict["title"] as? String {
                        self._title = title
                    }
                    if let descr = dict["description"] as? String {
                        self._description = descr
                    }
                    if let ingredients = dict["ingredients"] as? Array<String> {
                        self._ingredients = ingredients.joined(separator: "")
                        print("Ingredients", self._ingredients)
                        
                    }
                    if let preparing = dict["preparing"] as? Array<String> {
                        self._preparing = preparing.joined(separator: "\n")
                        print("Preparing", self._preparing)
                        
                    }
                    if let images = dict["imgs"] as? Array<String> {
                        self._images = images.joined(separator: "")
                        print("Images", self._images)
                        
                    }
                }
                DispatchQueue.main.async {
                    completed()
                }
            }
            
        }
    }
    
}


