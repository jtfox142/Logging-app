//
//  Log.swift
//  logging-app
//
//  Created by Jacob Fox on 9/7/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Log {
    var name: String
    var entries: [Entry]
    var tags: [String]

    init(name: String = "", entries: [Entry] = [], tags: [String] = []) {
        self.name = name
        self.entries = entries
        self.tags = tags
    }
    
    func add(entry: Entry) {
        entries.append(entry)
    }
    
    func attach(tag: String) {
        tags.append(tag)
    }
}
