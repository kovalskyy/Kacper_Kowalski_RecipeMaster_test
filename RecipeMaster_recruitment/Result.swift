//
//  Result.swift
//  RecipeMaster_recruitment
//
//  Created by Moodup on 20.11.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import Foundation

enum Result <T> {
    case success(T)
    case failure(RecipeApiError)
}

enum RecipeApiError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case invalidURL
    case jsonParsingFailure
}

