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
            ForEach(log.entries) { entry in
                NavigationLink {
                    EditEntryView(entry: entry)
                } label: {
                    VStack(alignment: .leading) {
                        Text(entry.date, style: .date)
                            .font(.headline)
                        Text(entry.desc)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                }
            }
        }
        .navigationTitle(log.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                NavigationLink("Add entry", destination: CreateEntryView(log: log))
            }
        }
        /*.navigationDestination(for: Log.self) { log in
            CreateEntryView(log: log)
        }*/
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
