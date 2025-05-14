import SwiftUI

struct HomeView: View {
    @State private var selectedCategory: String = "My Picks"
    @State private var events: [TicketEvent] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack {
                // Top Category Navigation
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        CategoryButton(title: "My Picks", isSelected: selectedCategory == "My Picks") {
                            selectedCategory = "My Picks"
                            fetchEvents()
                        }
                        CategoryButton(title: "Sports", isSelected: selectedCategory == "Sports") {
                            selectedCategory = "Sports"
                            fetchEvents()
                        }
                        CategoryButton(title: "Live Music", isSelected: selectedCategory == "Live Music") {
                            selectedCategory = "Live Music"
                            fetchEvents()
                        }
                        CategoryButton(title: "Others", isSelected: selectedCategory == "Others") {
                            selectedCategory = "Others"
                            fetchEvents()
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)

                if isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    // Event Grid Based on Selected Category
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(events, id: \.id) { event in
                                NavigationLink(destination: EventDetailView(event: event)) {
                                    EventCard(event: event)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Upcoming Events")
            .onAppear {
                fetchEvents()
            }
        }
    }

    private func fetchEvents() {
        isLoading = true
        errorMessage = nil
        
        // TODO: Implement actual API call to TicketMaster
        // For now, we'll simulate a network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Simulate API response
            self.events = [
                TicketEvent(
                    name: "Sample Concert",
                    type: "Music",
                    id: "1",
                    url: "https://example.com",
                    dates: EventDates(start: EventStart(localDate: "2024-03-20", localTime: "19:00")),
                    images: [
                        EventImages(
                            ratio: 1.0,
                            url: "https://example.com/image.jpg",
                            width: 800,
                            height: 600,
                            fallback: false
                        )
                    ]
                )
            ]
            self.isLoading = false
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
    let event: TicketEvent
    
    var body: some View {
        VStack(alignment: .leading) {
            if let firstImage = event.images.first {
                AsyncImage(url: URL(string: firstImage.url)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                }
                .frame(height: 120)
                .clipped()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(event.name)
                    .font(.headline)
                    .lineLimit(2)
                
                if let date = event.dates.start.localDate,
                   let time = event.dates.start.localTime {
                    Text("\(date) \(time)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
