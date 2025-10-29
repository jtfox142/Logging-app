//
//  CreateLogView.swift
//  logging-app
//
//  Created by Jacob Fox on 10/23/25.
//

//TODO: Figure out a way to reuse CreateEntryView instead of having redundant entry creation code

import SwiftUI

struct CreateLogView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var log: Log
    @State private var firstEntry: Entry = Entry()
    @State private var showDiscardAlert: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("New Log")) {
                TextField("Name", text: $log.name)
            }
            Section(header: Text("First Entry")) {
                DatePicker(
                    "Date Of Entry:",
                    selection: $firstEntry.date,
                    displayedComponents: [.date]
                )
                TextField("Description:", text: $firstEntry.desc)
            }
            Button("Save Log") {
                saveAndExit()
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
                modelContext.delete(log)
                dismiss()
            }
            Button("Cancel", role: .cancel) { }
        }
    }
    
    func saveAndExit() {
        log.entries.append(firstEntry)
        dismiss()
    }
}

#Preview {
    CreateLogView(log: Log())
}
