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

    init(name: String = "", entries: [Entry] = []) {
        self.name = name
        self.entries = entries
    }
    
    func add(entry: Entry) {
        entries.append(entry)
    }
}
