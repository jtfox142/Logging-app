//
//  ContentView.swift
//  logging-app
//
//  Created by Jacob Fox on 7/3/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var logs: [Log]
    @State private var path = [Log]()

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
                ForEach(logs) { log in
                    NavigationLink(log.name) {
                        EditLogView(log: log)
                    }
                }
                .onDelete(perform: deleteLogs)
            }
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
            .navigationDestination(for: Log.self, destination: CreateLogView.init)
        }
    }
    
    func addLog() {
        let log = Log()
        modelContext.insert(log)
        path = [log]
    }

    private func deleteLogs(indexSet: IndexSet) {
        withAnimation {
            for index in indexSet {
                let log = logs[index]
                modelContext.delete(log)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Log.self, inMemory: true)
}
