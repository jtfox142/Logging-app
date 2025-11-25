//
//  TagView.swift
//  logging-app
//
//  Created by Jacob Fox on 11/18/25.
//

import SwiftUI
import WrappingHStack

struct TagView: View {
    @State var log: Log
    
    var body: some View {
        WrappingHStack(alignment: .topLeading) {
            ForEach(log.tags, id: \.self) {tag in
                Text(tag)
                    .padding(.vertical, 8) // Adjust vertical padding for text
                    .padding(.horizontal, 16) // Adjust horizontal padding for text
                    .background(
                        Capsule()
                            .fill(Color.gray.opacity(0.2)) // Fill the capsule with a color
                    )
            }
        }
    }
}

#Preview {
    let log: Log = Log(name: "JFK", entries: [], tags: ["President", "Assassinated", "Handsome", "Dead", "Houstin"])
    TagView(log: log)
}
