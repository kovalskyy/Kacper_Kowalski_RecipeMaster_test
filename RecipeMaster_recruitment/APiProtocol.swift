//
//  APiProtocol.swift
//  RecipeMaster_recruitment
//
//  Created by Moodup on 22.11.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import Foundation
import RxSwift

protocol ApiProtocol {
    func getRecipe() -> Observable<Recipe>
}
