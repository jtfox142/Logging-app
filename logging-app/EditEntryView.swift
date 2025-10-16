//
//  EditEntryView.swift
//  logging-app
//
//  Created by Jacob Fox on 9/9/25.
//

/*import SwiftUI

struct EditEntryView: View {
    @State private var newEntry: Entry? = nil
    
    var body: some View {
        Form {
            TextField("Name", text: $log.name)
            Section("Entries") {
                ForEach(log.entries) { entry in
                    VStack {
                        Text(entry.desc)
                        Text(entry.date)
                    }
                    
                    HStack {
                        TextField("Add a new entry in \(log.name)", text: $newSightName)
                        TextField("Description", text: $entry.desc, axis: .vertical)
                        DatePicker("Date", selection: $log.date)
                        Button("Add", action: addSight)
                    }
                }
            }
        }
        .navigationTitle(log.name == "" ? "New Log" : log.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addEntry() {
        withAnimation {
            let entry = Entry(date: newEntry.date, desc: newEntry.desc)
            log.entries.append(entry)
            newEntry = ""
        }
    }
}
}

#Preview {
    EditEntryView()
}
*/
