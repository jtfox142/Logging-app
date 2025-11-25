//
//  Tag.swift
//  logging-app
//
//  Created by Jacob Fox on 11/25/25.
//

import Foundation
import SwiftData

@Model
class Tag: Identifiable {
    var id: String { name }
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
