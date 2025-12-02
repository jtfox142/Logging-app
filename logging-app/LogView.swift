//
//  LogView.swift
//  logging-app
//
//  Created by Jacob Fox on 11/26/25.
//

import SwiftUI
import SwiftData

//Allows the user to view all logs associated with the selected list
struct LogView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var list: ListOfLogs
    @Query private var tagLibrary: [Tag]
    @State private var searchText: String = ""
    @State private var selectedTags = [Tag]()
    
    var body: some View {
        ZStack {
            //Color.brown.opacity(0.1)
            Color(.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
                SearchBar(searchText: $searchText, tagLibrary: tagLibrary)
                List {
                    ForEach(searchResults) { log in
                        NavigationLink(log.name) {
                            EditLogView(log: log)
                        }
                    }
                    //.onDelete(perform: deleteLog)
                }
                .scrollContentBackground(.hidden)
            
                /*.searchable(text: $searchText, prompt: "Type to filter by name, or use # for tags", suggestions: {
                 if(searchText.first == "#") {
                 ForEach(suggestedTags, id: \.self) { tag in
                 Text(tag.name)
                 .searchCompletion("#" + tag.name)
                 }
                 }
                 })*/
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(list.name)
                            .fontWeight(.bold)
                            .font(.largeTitle)
                    }
                    ToolbarItem(placement: .bottomBar) {
                        NavigationLink {
                            CreateLogView(list: list, tagLibrary: tagLibrary)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }
    
    //TODO: Filter with multiple tags or with tag and log name
    var searchResults: [Log] {
        var logs = self.list.logs
        
        //Chack for empty search field
        if searchText.count > 0 {
            //Tags
            if(searchText.first == "#") {
                return logs.filter { log in
                    let tagName = String(searchText.split(separator: "#").last?.lowercased() ?? "")
                    let lowercasedTags = log.tags.map { $0.lowercased() }
                    return lowercasedTags.contains(where: { $0.contains(tagName) })
                }
            }
            //Log name
            logs = logs.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        return logs
    }

    private func deleteLog(indexSet: IndexSet) {
        withAnimation {
            for index in indexSet {
                let log = list.logs[index]
                modelContext.delete(log)
            }
        }
    }
    
    struct SearchBar: View {
        @Binding var searchText: String
        var tagLibrary: [Tag]
        
        var body: some View {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Type to filter by name, or use # for tags", text: $searchText)
                
            }
                .padding(5)
                .background(Color(.systemFill))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemFill), lineWidth: 1)
                )
                .containerRelativeFrame(.horizontal) { length, axis in
                    length * 0.8 // 80% of the container's horizontal length
                }
        }
    }
}



#Preview {
    let exampleLogs: [Log] = [Log(name: "Playboi Carti", entries: [Entry(date: Date(), desc: "Worked on a new track")], tags: ["Music"]), Log(name: "SZA", entries: [], tags: []), Log(name: "Drake", entries: [], tags: [])]
    let exampleList: ListOfLogs = ListOfLogs(name: "ExampleList", logs: exampleLogs)
    LogView(list: exampleList)
}
