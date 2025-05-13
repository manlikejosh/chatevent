import SwiftUI

struct HomeView: View {
    @State private var selectedCategory: String = "My Picks"

    // Mock data for events
    // Mock data for events
    // Mock data for events
    let sportsEvents = [
        Event(id: UUID(), banner: "team1_vs_team2", title: "Lakers vs Celtics", time: "Jan 12, 6:00 PM"),
        Event(id: UUID(), banner: "team3_vs_team4", title: "Heat vs Bulls", time: "Jan 13, 7:30 PM"),
        Event(id: UUID(), banner: "team5_vs_team6", title: "Warriors vs Nets", time: "Jan 15, 5:00 PM"),
        Event(id: UUID(), banner: "team7_vs_team8", title: "Knicks vs Raptors", time: "Jan 18, 7:00 PM"),
        Event(id: UUID(), banner: "team9_vs_team10", title: "Spurs vs Rockets", time: "Jan 20, 8:00 PM"),
        Event(id: UUID(), banner: "team11_vs_team12", title: "Mavericks vs Suns", time: "Jan 22, 7:00 PM"),
        Event(id: UUID(), banner: "team13_vs_team14", title: "Hawks vs Jazz", time: "Jan 25, 6:30 PM"),
        Event(id: UUID(), banner: "team15_vs_team16", title: "Bucks vs 76ers", time: "Jan 27, 8:00 PM"),
        Event(id: UUID(), banner: "team17_vs_team18", title: "Clippers vs Grizzlies", time: "Jan 29, 9:00 PM"),
        Event(id: UUID(), banner: "team19_vs_team20", title: "Trail Blazers vs Pelicans", time: "Jan 31, 6:00 PM")
    ]

    let liveMusicEvents = [
        Event(id: UUID(), banner: "concert1", title: "Taylor Swift Live", time: "Jan 20, 8:00 PM"),
        Event(id: UUID(), banner: "concert2", title: "Coldplay Live", time: "Feb 10, 7:30 PM"),
        Event(id: UUID(), banner: "concert3", title: "Ed Sheeran Concert", time: "Feb 15, 8:00 PM"),
        Event(id: UUID(), banner: "concert4", title: "Adele: One Night Only", time: "Feb 20, 9:00 PM"),
        Event(id: UUID(), banner: "concert5", title: "Drake: Live in Concert", time: "Feb 25, 7:00 PM"),
        Event(id: UUID(), banner: "concert6", title: "Beyoncé World Tour", time: "Mar 1, 8:00 PM"),
        Event(id: UUID(), banner: "concert7", title: "Bruno Mars Live", time: "Mar 5, 9:00 PM"),
        Event(id: UUID(), banner: "concert8", title: "Justin Bieber Concert", time: "Mar 10, 7:00 PM"),
        Event(id: UUID(), banner: "concert9", title: "The Weeknd: After Hours", time: "Mar 15, 8:00 PM"),
        Event(id: UUID(), banner: "concert10", title: "Harry Styles: Love on Tour", time: "Mar 20, 7:30 PM")
    ]

    let otherEvents = [
        Event(id: UUID(), banner: "expo1", title: "Tech Expo 2025", time: "Mar 5, 10:00 AM"),
        Event(id: UUID(), banner: "expo2", title: "Auto Show", time: "Mar 8, 11:00 AM"),
        Event(id: UUID(), banner: "expo3", title: "Game Developers Conference", time: "Mar 12, 9:00 AM"),
        Event(id: UUID(), banner: "festival1", title: "Food Festival", time: "Mar 20, 12:00 PM"),
        Event(id: UUID(), banner: "festival2", title: "Cultural Fest", time: "Mar 25, 1:00 PM"),
        Event(id: UUID(), banner: "expo4", title: "Startup Grind 2025", time: "Mar 28, 10:30 AM"),
        Event(id: UUID(), banner: "expo5", title: "Health & Wellness Expo", time: "Mar 30, 2:00 PM"),
        Event(id: UUID(), banner: "expo6", title: "Art & Craft Festival", time: "Apr 3, 11:00 AM"),
        Event(id: UUID(), banner: "festival3", title: "Music & Arts Festival", time: "Apr 10, 3:00 PM"),
        Event(id: UUID(), banner: "expo7", title: "AI Summit 2025", time: "Apr 15, 9:00 AM")
    ]
    

    // Lazy variable for myPicks
    var myPicks: [Event] {
        Array(sportsEvents.prefix(5)) + Array(liveMusicEvents.prefix(5))
    }




    var body: some View {
        NavigationView {
            VStack {
                // Top Category Navigation
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        CategoryButton(title: "My Picks", isSelected: selectedCategory == "My Picks") {
                            selectedCategory = "My Picks"
                        }
                        CategoryButton(title: "Sports", isSelected: selectedCategory == "Sports") {
                            selectedCategory = "Sports"
                        }
                        CategoryButton(title: "Live Music", isSelected: selectedCategory == "Live Music") {
                            selectedCategory = "Live Music"
                        }
                        CategoryButton(title: "Others", isSelected: selectedCategory == "Others") {
                            selectedCategory = "Others"
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)

                // Event Grid Based on Selected Category
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(getEventsForCategory()) { event in
                            NavigationLink(destination: EventDetailView(event: event)) {
                                EventCard(event: event)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Upcoming Events")
        }
    }

    // Helper Function to Get Events for Selected Category
    func getEventsForCategory() -> [Event] {
        switch selectedCategory {
        case "My Picks": return myPicks
        case "Sports": return sportsEvents
        case "Live Music": return liveMusicEvents
        case "Others": return otherEvents
        default: return []
        }
    }
}

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(isSelected ? .white : .blue)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(isSelected ? Color.blue : Color.clear)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.blue, lineWidth: isSelected ? 0 : 1)
                )
        }
    }
}
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

