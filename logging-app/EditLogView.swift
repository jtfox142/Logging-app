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
        //ZStack for overlaying entry and tag views. Maybe not the most efficient way to do what I'm trying to do, but TabView was the only alternative that I currently know of and that needs to be at the root
        ZStack {
            //Entry list
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
            
            //Tag list
            List(log.tags, id: \.self) {tag in
                Text(tag)
            }
            .zIndex(tagIndex)
        }
        .navigationTitle(log.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            //Title
            ToolbarItem(placement: .principal) {
                TextField(log.name, text: $log.name)
                    .fontWeight(.bold)
                    .font(.largeTitle)
            }
            //Add Button
            ToolbarItem(placement: .navigationBarTrailing) {
                //Switch between adding entries and adding tags
                if(entryIndex > tagIndex) {
                    NavigationLink(destination: CreateEntryView(log: log)) {
                        Image(systemName: "plus")
                    }
                } else {
                    createTagPopover(log: log)
                }
            }
            //Switch between entry view and tag view
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
        }
    }
    
    private func deleteEntry(indexSet: IndexSet) {
        withAnimation {
            for index in indexSet {
                log.entries.remove(at: index)
            }
        }
    }
    
    private func deleteTag(indexSet: IndexSet) {
        withAnimation {
            for index in indexSet {
                log.tags.remove(at: index)
            }
        }
    }
}

struct createTagPopover: View {
    @Bindable var log: Log
    @State var showingAlert: Bool = false
    var alertTitle: String = "Enter new tag name: "
    @State var alertMessage: String = ""
    var alertButtonText: String = "Confirm"

    var body: some View {
        Button(action: {
            showingAlert = true
        }) {
            Image(systemName: "plus")
        }.alert(Text(alertTitle),
            isPresented: $showingAlert,
            actions: {
            Button(alertButtonText) { log.tags.append(alertMessage) }
                Button("Cancel", role: .cancel) { }
            TextField("Tag Name", text: $alertMessage)
            }, message: {
                Text("Assigns this tag to the selected log")
            }
        )
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Log.self, configurations: config)
        
        let exampleEntry = Entry(date: Date(), desc: "Hello, World!")
        let exampleTags = ["first", "second", "third", "fourth", "fifth"]
        let example = Log(name: "Example Log", entries: [exampleEntry], tags: exampleTags)
        return EditLogView(log: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container: \(error)")
    }
}
