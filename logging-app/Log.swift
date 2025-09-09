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
    var id: UUID
    var date: Date
    var name: String
    var message: String
    
    init(id: UUID, date: Date, name: String, message: String) {
        self.id = id
        self.date = date
        self.name = name
        self.message = message
    }
}
