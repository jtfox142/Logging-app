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
            
            ForEach(log.entries) { entry in
                NavigationLink(value: entry) {
                    VStack(alignment: .leading) {
                        Text(entry.date, style: .date)
                            .font(.headline)
                        Text(entry.desc)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                }
            }
            .navigationTitle(log.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Log.self, configurations: config)
        
        let exampleEntry = Entry(date: Date(), desc: "Hello, World!")
        let example = Log(name: "Example Log", entries: [exampleEntry])
        return EditLogView(log: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container: \(error)")
    }
}
