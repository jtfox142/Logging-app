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
    @Query private var items: [Item]

    var body: some View {
        VStack {
            HStack {
                Text("Logger")
                    .font(.system(size: 48, weight: .bold, design: .monospaced))
                Image(systemName: "tree.fill")
                    .symbolRenderingMode(.multicolor)
                    .symbolEffect(.wiggle.byLayer, options: .repeat(.periodic(delay: 2.0)))
                    .font(.system(size: 48))
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
