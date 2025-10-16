//
//  LogDetailView.swift
//  logging-app
//
//  Created by Jacob Fox on 10/16/25.
//
import SwiftUI
import SwiftData

struct LogDetailView: View {
    @Bindable var log: Log  // ✅ This makes the model editable
    
    var body: some View {
        TextField("Name", text: $log.name)
        List(log.entries) { entry in
            Text(entry.desc)
        }
    }
}
