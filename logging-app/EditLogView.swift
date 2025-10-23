//
//  EditLogView.swift
//  logging-app
//
//  Created by Jacob Fox on 9/8/25.
//

import SwiftUI
import SwiftData

struct EditLogView: View {
    //@Environment(\.modelContext) private var modelContext
    @Bindable var log: Log
    @State private var path = [Entry]()
    
    var body: some View {
        NavigationStack() {
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
                    NavigationLink("Add entry", value: log)
                }
            }
            .navigationDestination(for: Log.self) { log in
                CreateEntryView(log: log)
            }
        }
    }
    
    func addEntry() {
        let entry = Entry()
        log.entries.append(Entry())
        //modelContext.insert(entry)
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
