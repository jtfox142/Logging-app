//
//  CreateLogView.swift
//  logging-app
//
//  Created by Jacob Fox on 10/23/25.
//

//TODO: Figure out a way to reuse CreateEntryView instead of having redundant entry creation code

import SwiftUI
import SwiftData

struct CreateLogView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var list: ListOfLogs
    @State var log: Log = Log()
    @State var tagLibrary: [Tag]
    @State private var firstEntry: Entry = Entry()
    @State private var showDiscardAlert: Bool = false
    @State private var disableSave: Bool = true
    @State private var searchText: String = ""
    @State private var suggestions: [String] = []
    @State private var isExpanded: Bool = true
    
    var body: some View {
        Form {
            Section(header: Text("New Log")) {
                TextField("Name", text: $log.name)
                    .onChange(of: self.log.name) {
                        disableSave = self.log.name.isEmpty
                    }
            }
            Section(header: Text("First Entry")) {
                DatePicker(
                    "Date Of Entry:",
                    selection: $firstEntry.date,
                    displayedComponents: [.date]
                )
                TextField("Description:", text: $firstEntry.desc)
            }
            Section(header: Text("Tags")) {
                VStack {
                    TextField("Add Tag", text: $searchText)
                        .onChange(of: searchText) {
                            updateSuggestions()
                        }
                        .onSubmit {
                            addTag(name: searchText)
                            searchText = ""
                        }
                        .padding(.vertical, 5)

                    if !suggestions.isEmpty {
                        List(suggestions, id: \.self) { suggestion in
                            Divider()
                            Button(action: {
                                searchText = suggestion
                                suggestions = []
                            }) {
                                Text(suggestion)
                                    .padding(.vertical, 5)
                            }
                        }
                        .frame(maxHeight: 200) // Limit the height of the suggestions list
                    }
                }
            }
            Section {
                DisclosureGroup("Selected Tags", isExpanded: $isExpanded) {
                    ForEach(log.tags, id: \.self) {tag in
                        Text(tag)
                    }
                    .onDelete(perform: deleteTag)
                }
            }
            Button("Save Log") {
                saveAndExit()
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .disabled(disableSave)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    showDiscardAlert = true;
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
        }
        .alert("Discard changes?", isPresented: $showDiscardAlert) {
            Button("Discard", role: .destructive) {
                modelContext.delete(log)
                dismiss()
            }
            Button("Cancel", role: .cancel) { }
        }
    }
    
    private func saveAndExit() {
        log.entries.append(firstEntry)
        list.logs.append(log)
        dismiss()
    }
    
    private func addTag(name: String) {
        //Don't create an empty tag
        if(name.isEmpty) {
            return
        }
        
        //Check to make sure the tag exists in the Tag Library so that it can be suggested for other logs
        if(!tagLibrary.contains(where: { $0.name.lowercased() == name.lowercased() })) {
            tagLibrary.append(Tag(name: name))
            modelContext.insert(Tag(name: name))
        }
        
        //If the log already contains the tag, do not attach it again
        if(!log.tags.contains(where: { $0.lowercased() == name.lowercased() })) {
            log.attach(tag: name)
        } else {
            //TODO: Create a popup that fades away, informing the user that the tag has already been added
            return
        }
    }
    
    private func deleteTag(indexSet: IndexSet) {
        withAnimation {
            for index in indexSet {
                log.tags.remove(at: index)
            }
        }
    }
    
    private func updateSuggestions() {
        // Update the suggestions based on the query
        if searchText.isEmpty {
            suggestions = []
        } else {
            let tagNames: [String] = tagLibrary.map(\.name)
            suggestions = tagNames.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }
}

#Preview {
    let exampleLogs: [Log] = [Log(name: "Playboi Carti", entries: [Entry(date: Date(), desc: "Worked on a new track")], tags: ["Music"]), Log(name: "SZA", entries: [], tags: []), Log(name: "Drake", entries: [], tags: [])]
    let exampleList: ListOfLogs = ListOfLogs(name: "ExampleList", logs: exampleLogs)
    CreateLogView(list: exampleList, tagLibrary: [])
}
