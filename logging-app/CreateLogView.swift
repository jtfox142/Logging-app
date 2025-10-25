//
//  CreateLogView.swift
//  logging-app
//
//  Created by Jacob Fox on 10/23/25.
//

import SwiftUI

struct CreateLogView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var log: Log  // ✅ This makes the model editable
    @State private var firstEntry: Entry = Entry()
    
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
    }
    
    func saveAndExit() {
        log.entries.append(firstEntry)
        dismiss()
    }
}

#Preview {
    CreateLogView(log: Log())
}
