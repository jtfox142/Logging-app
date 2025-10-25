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
    
    var body: some View {
        Form {
            Section(header: Text("New Log")) {
                TextField("Name", text: $log.name)
            }
            Button("Save Log") {
                saveAndExit()
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    func saveAndExit() {
        dismiss()
    }
}

#Preview {
    CreateLogView(log: Log())
}
