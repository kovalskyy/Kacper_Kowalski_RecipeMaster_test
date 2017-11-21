//
//  Account.swift
//  RecipeMaster_recruitment
//
//  Created by Moodup on 21.11.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import Foundation
import Gloss

final class Account: Glossy {
    
    let id: Int
    let firstName: String?
    let lastName: String?
    let username: String
    let authToken: String
    let email: String?
    
    init?(json: JSON) {
        guard let id: Int = "id" <~~ json,
            let username: String = "username" <~~ json,
            let authToken: String = "auth_token" <~~ json else { return nil }
        
        self.id = id
        self.username = username
        self.authToken = authToken
        
        email = "email" <~~ json
        firstName = "first_name" <~~ json
        lastName = "last_name" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
                        "id" ~~> id,
                        "first_name" ~~> firstName,
                        "last_name" ~~> lastName,
                        "username" ~~> username,
                        "auth_token" ~~> authToken,
                        "email" ~~> email
                    ])
    }
}
