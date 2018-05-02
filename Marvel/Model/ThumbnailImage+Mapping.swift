//
//  ThumbnailImage+Mapping.swift
//  Marvel
//
//  Created by Nidhi Goyal on 03/05/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation

extension ThumbnailImage {
    
    static func entity(withDictionary dictionary: [AnyHashable: JSON]) -> ThumbnailImage? {
        let entity = ThumbnailImage()
        
        entity.path = dictionary["path"]?.string
        entity.imageExtension = dictionary["extension"]?.string
        return entity
    }
}
