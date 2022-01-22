//
//  User.swift
//  Pohudeyka
//
//  Created by Сергей Лукичев on 22.01.2022.
//

import Foundation
import Firebase

struct User {
    let name: String
    var results: [Result]?
    
    let uuid = UUID()
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    struct Result: Hashable {
        let data: String
        let weight: Double
        
        let uuid = UUID()
        
        static func == (lhs: Result, rhs: Result) -> Bool {
            lhs.uuid == rhs.uuid
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(uuid)
        }
    }
}
