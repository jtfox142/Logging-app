//
//  ContentView.swift
//  logging-app
//
//  Created by Jacob Fox on 7/3/25.
//

//THE MASTER TODO LIST (In logical order of completion)

//TODO: TechDebt: CreateEntryView could be edited to be much more reusable. It is emulated with only minor changes in both CreateLogView and EditEntryView
//TODO: Feature: Make logs and entries sortable (Sort by: Default (name), first entry date, latest entry date)
//TODO: Feature: Add a field to allow for custom tags on logs. Allow the user to sort/search using these custom tags. When the user is typing in the tag field of a log, suggest to autocomplete for tags they've used before
//TODO: Feature: Create lists. Lists are a parent to logs in the same way logs are a parent to entries. 

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Log.name) private var logs: [Log]
    @State var tags: TagLibrary = TagLibrary()
    @State private var path = [Log]()
    @State private var searchText: String = ""

    var body: some View {
        /*VStack {
            HStack {
                Text("Logger")
                    .font(.system(size: 48, weight: .bold, design: .monospaced))
                Image(systemName: "tree.fill")
                    .symbolRenderingMode(.multicolor)
                    .symbolEffect(.wiggle.byLayer, options: .repeat(.periodic(delay: 2.0)))
                    .font(.system(size: 48))
            }
        }*/
        NavigationStack(path: $path) {
            List {
                ForEach(searchResults) { log in
                    NavigationLink(log.name) {
                        EditLogView(log: log)
                    }
                }
                .onDelete(perform: deleteLog)
            }
            .searchable(text: $searchText, prompt: "Type to filter by name, or use # for tags")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Logs")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                }
                ToolbarItem(placement: .bottomBar) {
                    Button("Add Logs", systemImage: "plus", action: addLog)
                }
            }
            .navigationDestination(for: Log.self) { log in
                CreateLogView(log: log, tagLibrary: tags)
            }
        }
    }
    
    var searchResults: [Log] {
        if(searchText.isEmpty) {
            return logs
        } else {
            return logs.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    private func addLog() {
        let log = Log()
        modelContext.insert(log)
        path = [log]
    }

    private func deleteLog(indexSet: IndexSet) {
        withAnimation {
            for index in indexSet {
                let log = logs[index]
                modelContext.delete(log)
            }
        }
    }
    
    /*private func searchLogs(text: String) -> [Log] {
        
    }*/
}

#Preview {
    ContentView()
        .modelContainer(for: Log.self, inMemory: true)
}
