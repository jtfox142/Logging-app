//
//  CreateEntryView.swift
//  logging-app
//
//  Created by Jacob Fox on 10/23/25.
//

//TODO: Discard entry if the back button is pressed. Make description box push text onto next line.

import SwiftUI
import SwiftData

struct CreateEntryView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var log: Log  // ✅ This makes the model editable
    @State private var entry: Entry = Entry()
    
    var body: some View {
        Form {
            Section(header: Text("New Entry")) {
                DatePicker(
                    "Date Of Entry:",
                    selection: $entry.date,
                    displayedComponents: [.date]
                )
                TextField("Description:", text: $entry.desc)
            }
            Button("Save Entry") {
                saveEntry(entry: entry)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    func saveEntry(entry: Entry) {
        log.entries.append(entry)
        dismiss()
    }
}

#Preview {
    CreateEntryView(log: Log())
}
