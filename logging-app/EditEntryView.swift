//
//  EditEntryView.swift
//  logging-app
//
//  Created by Jacob Fox on 9/9/25.
//

import SwiftUI
import SwiftData
import Foundation

//TODO: This is basically the same as CreateEntryView. Edit CreateEntryView to be reusable

struct EditEntryView: View {
    @Bindable var entry = Entry()
    //@State private var newEntry: Entry? = nil
    
    var body: some View {
        Form {
            Section("Entries") {
                VStack {
                    DatePicker(
                        "Date Of Entry:",
                        selection: $entry.date,
                        displayedComponents: [.date]
                    )
                    TextField("Description: ", text: $entry.desc)
                }
            }
        }
    }
}

#Preview {
    EditEntryView()
}
