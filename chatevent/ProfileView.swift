import SwiftUI

struct ProfileView: View {
    // Sample data for events and achievements
    let attendedEvents = ["Lakers", "Taylor Swift", "Celtics", "Food Festival"]
    let earnedBadges = [
        "My First NBA Game",
        "My 5th NBA Game",
        "My 10th Mavs Game",
        "My 2nd Taylor Concert",
        "My 10th Concert"
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            // Profile Header
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .padding(.top)
            
            Text("@eliyanm")
                .font(.headline)
                .foregroundColor(.gray)
            
            Text("eliyan memon")
                .font(.title)
                .fontWeight(.bold)
            
            Text("This is a small bio. I love going to events and collecting badges!")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            // Achievements Section (Badges)
            VStack(alignment: .leading, spacing: 10) {
                Text("Achievements")
                    .font(.headline)
                    .padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(earnedBadges, id: \.self) { badge in
                            BadgeCardView(badgeTitle: badge)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            // Events You've Been To Section
            VStack(alignment: .leading, spacing: 10) {
                Text("Events You've Been To")
                    .font(.headline)
                    .padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(attendedEvents, id: \.self) { event in
                            EventCardView(title: event)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            Spacer()
        }
        .navigationTitle("Profile")
    }
}

// Card view for displaying an achievement badge
struct BadgeCardView: View {
    let badgeTitle: String
    
    var body: some View {
        VStack(spacing: 8) {
            // Badge icon with a circular gradient background
            ZStack {
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange]),
                                         startPoint: .top, endPoint: .bottom))
                    .frame(width: 60, height: 60)
                Image(systemName: "star.fill")
                    .font(.title)
                    .foregroundColor(.white)
            }
            Text(badgeTitle)
                .font(.caption)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: 80)
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .frame(width: 100)
    }
}

// Card view for displaying an event (same style as in Home/Search)
struct profileEventCardView: View {
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
            // Event title text with wrapping support
            Text(title)
                .font(.subheadline)
                .padding([.leading, .trailing, .bottom], 5)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(width: 150, alignment: .leading)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}
