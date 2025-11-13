//
//  Tag.swift
//  logging-app
//
//  Created by Jacob Fox on 10/29/25.
//

import Foundation
import SwiftData

@Model
class TagLibrary {
    var tags: [String]
    
    init(tags: [String] = []) { self.tags = tags }
    
    func addTag(_ tag: String) {
        tags.append(tag)
    }
}

