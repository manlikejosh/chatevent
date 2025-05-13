import SwiftUI

// A simple model to represent a notification.
struct NotificationItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let time: String  // A simple string timestamp for now.
}

struct NotificationsView: View {
    // Sample notifications
    let notifications: [NotificationItem] = [
        NotificationItem(title: "New Event", message: "Taylor Swift concert is coming soon!", time: "2 hrs ago"),
        NotificationItem(title: "Ticket Update", message: "Your ticket for Tech Expo 2025 has been confirmed.", time: "Yesterday"),
        NotificationItem(title: "New Message", message: "You have a new message in the event chat.", time: "Just now"),
        NotificationItem(title: "Friend Activity", message: "John Doe is attending the Lakers game tonight.", time: "3 hrs ago"),
        NotificationItem(title: "Reminder", message: "Don't forget to swap your ticket for the expo.", time: "1 day ago")
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(notifications) { notif in
                    NotificationRow(notification: notif)
                        .listRowSeparator(.hidden)
                        .padding(.vertical, 5)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Notifications")
        }
    }
}

// A custom view representing a single notification row.
struct NotificationRow: View {
    let notification: NotificationItem
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Notification icon.
            Image(systemName: "bell.fill")
                .font(.title2)
                .foregroundColor(.blue)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(notification.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(notification.message)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                Text(notification.time)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 8)
            
            Spacer()
        }
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
