//
//  EventCard.swift
//  chatevent
//
//  Created by Joshua Hodgson on 5/14/25.
//

import SwiftUI

struct EventCard: View {
    let event: Event

    var body: some View {
        VStack(alignment: .leading) {
            Rectangle() // Placeholder for event banner
                .fill(Color.gray) // Replace this with Image(event.banner) when assets are added
                .frame(height: 120)
                .cornerRadius(10)

            Text(event.title)
                .font(.headline)
                .lineLimit(2) // Restricts the title to 2 lines
                .truncationMode(.tail) // Adds "..." if the text overflows
                .frame(maxWidth: .infinity, alignment: .leading) // Ensures alignment and layout

            Text(event.time)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 3)
        .frame(height: 200) // Ensures a consistent card height
    }
}


#Preview {
    EventCard(event:Event(id: UUID(), banner: "expo1", title: "Tech Expo 2025", time: "Mar 5, 10:00 AM")
)
}
