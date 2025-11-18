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
    @State private var entryIndex: Double = 3
    let tagIndex: Double = 2
    
    var body: some View {
        ZStack {
            VStack {
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
            }
            .zIndex(entryIndex)
            /*.tabItem {
                Label("Entries", systemImage: "book")
            }
            .tabItem {
                Label("Tags", systemImage: "tag")
            }*/
            List(log.tags, id: \.self) {tag in
                    Text(tag)
            }
            .zIndex(tagIndex)
        }
        .navigationTitle(log.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                TextField(log.name, text: $log.name)
                    .fontWeight(.bold)
                    .font(.largeTitle)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: CreateEntryView(log: log)) {
                    Image(systemName: "plus")
                }
            }
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Button {
                        entryIndex = 3
                    } label: {
                        Label("Entries", systemImage: "book")
                    }
                    .padding(.horizontal, 20)
                    
                    Divider()
                    
                    Button {
                        entryIndex = 1
                    } label: {
                        Label("Tags", systemImage: "tag")
                    }
                    .padding(.horizontal, 20)
                }
            }
            /*ToolbarItem(placement: .bottomBar) {
                Label("Entries", systemImage: "book")
            }
            ToolbarItem(placement: .bottomBar) {
                Label("Tags", systemImage: "tag")
            }*/
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

/*struct bottomBarStack: View {
    @Binding var entryIndex: Double
    var body: some View {
        HStack {
            Button {
                pushToTop(index: "entry")
            } label: {
                Label("Entries", systemImage: "book")
            }
            .padding(.horizontal, 20)
            
            Divider()
            
            Button {
                pushToTop(index: "tag")
            } label: {
                Label("Tags", systemImage: "tag")
            }
            .padding(.horizontal, 20)
        }
    }
    
    private func pushToTop(index: String) {
        if(index == "entry") {
            entryIndex = 3
        }
        else {
            entryIndex = 1
        }
    }
}*/

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
