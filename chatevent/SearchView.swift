import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    @State private var myPicks: [String] = []
    @State private var selectedCity: String = "Dallas, TX"
    
    // All placeholder events (for search filtering)
    let searchOptions = [
        "Lakers", "Celtics", "Taylor Swift", "Coldplay", "Tech Expo 2025",
        "Food Festival", "Spurs", "Beyoncé", "Art & Craft Festival",
        "Game Developers Conference", "Comic-Con"
    ]
    
    // For the temporary UI, we split the placeholders into different sections:
    let recommendedEvents = [
        "Lakers", "Taylor Swift", "Tech Expo 2025", "Beyoncé"
    ]
    let friendEvents = [
        "Celtics", "Coldplay", "Food Festival", "Art & Craft Festival"
    ]
    // New trending events section
    let trendingEvents = [
        "Game Developers Conference", "Spurs", "Comic-Con"
    ]
    
    // Filtered results based on the search query
    var filteredResults: [String] {
        searchOptions.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search for teams, artists, or shows...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.horizontal, .top])
                
                // If there's no search text, show the sections with recommendations
                if searchText.isEmpty {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            
                            // Recommended for You Section
                            Text("Recommended for You")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(recommendedEvents, id: \.self) { event in
                                        EventCardView(title: event)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            // Where Your Friends Are Going Section
                            Text("Where Your Friends Are Going")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(friendEvents, id: \.self) { event in
                                        EventCardView(title: event)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            // Trending Events Near [City] Section with Editable City TextField
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Trending Events Near")
                                    .font(.headline)
                                
                                HStack {
                                    TextField("City, State", text: $selectedCity)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    Button(action: {
                                        // Stub for current location functionality
                                        selectedCity = "Your Current Location"
                                    }) {
                                        Text("Current Location")
                                            .font(.subheadline)
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(trendingEvents, id: \.self) { event in
                                        EventCardView(title: event)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                } else {
                    // If the user is searching, show a list of filtered results
                    List {
                        if filteredResults.isEmpty {
                            Text("No results found")
                                .foregroundColor(.gray)
                        } else {
                            ForEach(filteredResults, id: \.self) { result in
                                HStack {
                                    Text(result)
                                    Spacer()
                                    if myPicks.contains(result) {
                                        Text("Added")
                                            .font(.caption)
                                            .foregroundColor(.green)
                                    } else {
                                        Button(action: {
                                            myPicks.append(result)
                                        }) {
                                            Text("Add to My Picks")
                                                .font(.caption)
                                                .foregroundColor(.blue)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .padding(.bottom, 60) // Added bottom padding so the content isn't covered by the tab view.
            .navigationTitle("Search")
        }
    }
}

// A simple card view for displaying events in the horizontal scroll sections.
struct EventCardView: View {
    let title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            // Placeholder image view
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 100)
                    .cornerRadius(8)
                Text("Image")
                    .foregroundColor(.white)
                    .font(.caption)
            }
            // Event title text with wrapping for longer names
            Text(title)
                .font(.subheadline)
                .padding([.leading, .trailing, .bottom], 5)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(width: 150, alignment: .leading)  // This fixes the width to enable proper wrapping.
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
