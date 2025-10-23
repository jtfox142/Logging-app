//
//  LogDetailView.swift
//  logging-app
//
//  Created by Jacob Fox on 10/16/25.
//

//TODO: Add save button, and discard entry if the back button is pressed

import SwiftUI
import SwiftData

struct LogDetailView: View {
    @Bindable var log: Log  // ✅ This makes the model editable
    
    var body: some View {
        Form {
            Section(header: Text("New Log")) {
                TextField("Name", text: $log.name)
            }
        }
    }
}
