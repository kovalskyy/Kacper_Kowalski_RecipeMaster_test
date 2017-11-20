//
//  RecipeModel.swift
//  RecipeMaster_recruitment
//
//  Created by Moodup on 20.11.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import Foundation
import Gloss

struct RecipeModel: Gloss.Decodable {
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


//struct RecipeModel {
//    let description: String
//    let images: [String]
//    let ingredients: [String]
//    let preparing: [String]
//    let title: String
//}
//
//extension RecipeModel {
//
//    struct Key {
//        static let description = "description"
//        static let images = "imgs"
//        static let ingredients = "ingredients"
//        static let preparing = "preparing"
//        static let title = "title"
//    }
//
//    init?(json: [String: AnyObject]) {
//        guard let description = json[Key.description] as? String,
//            let images = json[Key.images] as? [String],
//            let ingredients = json[Key.ingredients] as? [String],
//            let preparing = json[Key.preparing] as? [String],
//            let title = json[Key.title] as? String
//            else {
//                return nil
//        }
//        self.description = description
//        self.images = images
//        self.ingredients = ingredients
//        self.preparing = preparing
//        self.title = title
//    }
//}



