//
//  ContentView.swift
//  logging-app
//
//  Created by Jacob Fox on 7/3/25.
//

//THE MASTER TODO LIST (In logical order of completion)

//TODO: TechDebt: CreateEntryView could be edited to be much more reusable. It is emulated with only minor changes in both CreateLogView and EditEntryView
//TODO: Feature: Make logs and entries sortable (Sort by: Default (name), first entry date, latest entry date)
//TODO: TechDebt: Pull Search functions into a utilities folder
//TODO: Feature: Create lists. Lists are a parent to logs in the same way logs are a parent to entries.
    // Fix searchbar
    // Make tags save to modelContext when added through EditLogView

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var logLists: [ListOfLogs]
    @State private var path = [ListOfLogs]()
    @State private var showingAlert: Bool = false
    @State var userInput: String = ""
    
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
                ForEach(logLists) { list in
                    NavigationLink(list.name) {
                        LogView(list: list)
                    }
                }
                .onDelete(perform: deleteList)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Lists")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                }
                ToolbarItem(placement: .bottomBar) {
                    let alertTitle: String = "Enter new list name: "
                    let alertButtonText: String = "Confirm"
                    Button(action: {
                        showingAlert = true
                    }) {
                        Image(systemName: "plus")
                    }
                        .alert(Text(alertTitle),
                            isPresented: $showingAlert,
                            actions: {
                            Button(alertButtonText) { modelContext.insert(ListOfLogs(name: userInput)) }
                                Button("Cancel", role: .cancel) { }
                                TextField("Tag Name", text: $userInput)
                            }
                    )
                }
            }
        }
    }
    
    private func deleteList(indexSet: IndexSet) {
        
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ListOfLogs.self, inMemory: true)
}
