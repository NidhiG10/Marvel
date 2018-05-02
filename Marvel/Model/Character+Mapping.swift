//
//  Character+Mapping.swift
//  Marvel
//
//  Created by Nidhi Goyal on 02/05/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation

extension Character {
    
    static func entity(withDictionary dictionary: [AnyHashable: JSON]) -> Character? {
        let entity = Character()
        
        entity.id = (dictionary["id"]?.integer)!
        entity.name = dictionary["name"]?.string
        entity.bio = dictionary["description"]?.string
        entity.image = dictionary["thumbnail"]?.string
        return entity
    }
}
