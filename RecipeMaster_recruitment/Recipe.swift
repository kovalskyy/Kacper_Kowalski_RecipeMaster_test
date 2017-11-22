//
//  Recipe.swift
//  RecipeMaster_recruitment
//
//  Created by Moodup on 20.11.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import Foundation
import ObjectMapper

class Recipe: Mappable {
    var description: String?
    var images: [String]?
    var ingredients: [String]?
    var preparing: [String]?
    var title: String?
    
    // MARK: ObjectMapper Initalizers
    required init?(map: Map) {}

    public func mapping(map: Map) {
        self.description <- map["description"]
        self.images  <- map["imgs"]
        self.ingredients <- map["ingredients"]
        self.preparing   <- map["preparing"]
        self.title   <- map["title"]
    }
}

