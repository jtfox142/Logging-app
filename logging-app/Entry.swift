//
//  Entry.swift
//  logging-app
//
//  Created by Jacob Fox on 9/9/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Entry {
    var date: Date
    var desc: String
    
    init(date: Date = Date(), desc: String = "") {
        self.date = date
        self.desc = desc
    }
}
