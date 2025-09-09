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
        NavigationStack {
            List {
                ForEach(logs) { log in
                    VStack(alignment: .leading) {
                        Text(log.name)
                            .font(.headline)
                        Text(log.message)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle(Text("Logs"))
            .toolbar {
                Button("Add Log", action: addLog)
            }
        }
    }

    private func addLog() {
        withAnimation {
            let newLog = Log(id: UUID(), date: Date(), name: "Test Log", message: "Hello, World!")
            modelContext.insert(newLog)
        }
    }

    private func deleteLogs(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(logs[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Log.self, inMemory: true)
}
