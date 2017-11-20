//
//  RecipeModel.swift
//  RecipeMaster_recruitment
//
//  Created by Moodup on 20.11.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import Foundation
import Gloss

final class RecipeModel: Gloss.Decodable {
    let description: String
    let images: [String]
    let ingredients: [String]
    let preparing: [String]
    let title: String
    
    init?(json: JSON) {
        guard let description: String = "description" <~~ json,
            let images: [String] = "imgs" <~~ json,
            let ingredients: [String] = "ingredients" <~~ json,
            let preparing: [String] = "preparing" <~~ json,
            let title: String = "title" <~~ json else { return nil }
        
        self.description = description
        self.images = images
        self.ingredients = ingredients
        self.preparing = preparing
        self.title = title
    }
}



