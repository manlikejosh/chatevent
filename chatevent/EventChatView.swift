import SwiftUI

struct EventChatView: View {
    @State private var messageText: String = "" // User's input message
    @State private var messages: [Message] = [] // Array to hold chat messages

    var body: some View {
        VStack {
            // Chat Messages List
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(messages) { message in
                        HStack {
                            if message.isCurrentUser {
                                Spacer() // Push the current user's message to the right
                                VStack(alignment: .trailing) {
                                    Text("@\(message.username)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(message.text)
                                        .padding()
                                        .background(Color.green.opacity(0.2))
                                        .cornerRadius(10)
                                    Text(message.timestamp, style: .time) // Displays the timestamp
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                }
                            } else {
                                VStack(alignment: .leading) {
                                    Text("@\(message.username)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(message.text)
                                        .padding()
                                        .background(Color.blue.opacity(0.2))
                                        .cornerRadius(10)
                                    Text(message.timestamp, style: .time)
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                }
                                Spacer() // Push other user's messages to the left
                            }
                        }
                    }
                }
                .padding()
            }

            // Input Field
            HStack {
                TextField("Enter your message...", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)

                Button(action: {
                    sendMessage()
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.blue)
                }
                .padding(.trailing)
            }
            .padding()
        }
        .navigationTitle("Chat")
    }

    // Function to Send Message
    func sendMessage() {
        guard !messageText.isEmpty else { return }
        let newMessage = Message(
            id: UUID(),
            text: messageText,
            timestamp: Date(),
            username: "eliyantest",
            isCurrentUser: true // All messages are current user for now
        )
        messages.append(newMessage) // Add the message to the array
        messageText = "" // Clear the input field
    }
}

// Message Model
struct Message: Identifiable {
    let id: UUID
    let text: String
    let timestamp: Date
    let username: String
    let isCurrentUser: Bool
}

struct EventChatView_Previews: PreviewProvider {
    static var previews: some View {
        EventChatView()
    }
}
