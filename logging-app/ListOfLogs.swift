//
//  ListOfLogs.swift
//  logging-app
//
//  Created by Jacob Fox on 11/26/25.
//

import Foundation
import SwiftData

@Model
class ListOfLogs {
    var name: String
    var logs: [Log]
    
    init(name: String, logs: [Log] = []) {
        self.name = name
        self.logs = logs
    }
}
