//
//  EditEntryView.swift
//  logging-app
//
//  Created by Jacob Fox on 9/9/25.
//

import SwiftUI
import SwiftData
import Foundation

struct EditEntryView: View {
    @Bindable var entry = Entry()
    //@State private var newEntry: Entry? = nil
    
    var body: some View {
        Form {
            Section("Entries") {
                    VStack {
                        Text(strDate(date: entry.date))
                        Text(entry.desc)
                    }
                    
                    /*HStack {
                        TextField("Add a new entry in \(log.name)", text: $newSightName)
                        TextField("Description", text: $entry.desc, axis: .vertical)
                        DatePicker("Date", selection: $log.date)
                        Button("Add", action: addSight)
                    }*/
                }
            }
        }
    
    /*func addEntry() {
        withAnimation {
            let entry = Entry(date: newEntry?.date ?? Date(), desc: newEntry?.desc ?? "")
            //log.entries.append(entry)
            //newEntry = ""
        }
    }*/

    func strDate(date: Date) -> String {
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "MM/dd/YY"

        // Convert Date to String
        let strDate = dateFormatter.string(from: date)
        
        return strDate
    }
}

#Preview {
    EditEntryView()
}
