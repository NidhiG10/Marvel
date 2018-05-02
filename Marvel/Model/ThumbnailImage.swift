//
//  ThumbnailImage.swift
//  Marvel
//
//  Created by Nidhi Goyal on 03/05/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation

class ThumbnailImage: NSObject {
    var path: String?
    var imageExtension: String?
    
    func fullPath() -> String {
        return "\(path ?? "").\(imageExtension ?? "")"
    }
}
