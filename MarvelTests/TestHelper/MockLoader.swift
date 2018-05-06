//
//  MockLoader.swift
//  MarvelTests
//
//  Created by Nidhi Goyal on 06/05/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation
import ObjectMapper
@testable import Marvel

struct MockLoader {
    
    let data: Data
    let json: JSON
    
    init?(file: String, withExtension fileExt: String = "json", in bundle:Bundle = Bundle.main) {
        guard let path = bundle.path(forResource: file, ofType: fileExt) else {
            return nil
        }
        let pathURL = URL(fileURLWithPath: path)
        do {
            data = try Data(contentsOf: pathURL, options: .dataReadingMapped)
            if let decoded = JSON(data) as JSON? {
                json = decoded
            } else {
                return nil
            }
        } catch{
            return nil
        }
    }
}
