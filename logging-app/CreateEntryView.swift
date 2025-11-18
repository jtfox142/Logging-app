//
//  CreateEntryView.swift
//  logging-app
//
//  Created by Jacob Fox on 10/23/25.
//

//TODO: Discard entry if the back button is pressed. Make description box expand downward and push text onto the next line if it overflows.

import SwiftUI
import SwiftData

struct CreateEntryView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var log: Log
    @State private var entry: Entry = Entry()
    @State private var showDiscardAlert: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Date")) {
                DatePicker(
                    "Date Of Entry:",
                    selection: $entry.date,
                    displayedComponents: [.date]
                )
            }
            Section("Description") {
                TextField("Description:", text: $entry.desc)
            }
            Button("Save Entry") {
                saveEntry(entry: entry)
            }
            .frame(maxWidth: .infinity, alignment: .center)
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
                dismiss()
            }
            Button("Cancel", role: .cancel) { }
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
