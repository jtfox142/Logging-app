//
//  EditLogView.swift
//  logging-app
//
//  Created by Jacob Fox on 9/8/25.
//

import SwiftUI
import SwiftData

struct EditLogView: View {
    @Bindable var log: Log
    
    var body: some View {
        Form {
            TextField("Name", text: $log.name)
            TextField("Message", text: $log.message, axis: .vertical)
            DatePicker("Date", selection: $log.date)
        }
        .navigationTitle(log.name ?? "Edit Log")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Log.self, configurations: config)
        
        let example = Log(date: Date(), name: "Example Log", message: "Hello, World!")
        return EditLogView(log: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container: \(error)")
    }
}
