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
            .onDelete(perform: deleteEntry)
        }
        .navigationTitle(log.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                TextField(log.name, text: $log.name)
                    .fontWeight(.bold)
                    .font(.largeTitle)
            }
            ToolbarItem(placement: .bottomBar) {
                NavigationLink("Add entry", destination: CreateEntryView(log: log))
                    .foregroundStyle(Color.blue)
            }
        }
        /*.navigationDestination(for: Log.self) { log in
            CreateEntryView(log: log)
        }*/
    }
    
    private func deleteEntry(indexSet: IndexSet) {
        withAnimation {
            for index in indexSet {
                log.entries.remove(at: index)
            }
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
