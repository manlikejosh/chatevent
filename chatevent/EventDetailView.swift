import SwiftUI

// MARK: - EventDetailView

struct EventDetailView: View {
    let event: Event  // Assumes your Event model is defined in Event.swift

    // Define an enum for the available subviews (tabs)
    enum DetailTab: String, CaseIterable {
        case feed = "Feed"
        case photos = "Photos"
        case tickets = "Tickets"
        case groups = "Groups"
    }
    
    @State private var selectedTab: DetailTab = .feed

    var body: some View {
        VStack(alignment: .leading) {
            // MARK: - Top Section: Event Basic Info & Venue
            VStack(alignment: .leading, spacing: 8) {
                Text(event.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Start Time: \(event.time)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Live Score: Team A 78 - Team B 83")
                    .font(.headline)
                    .foregroundColor(.red)
                
                // Venue Address: When tapped, opens Apple Maps.
                Button(action: {
                    openMapForAddress("123 Main St, City, State")
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "mappin.and.ellipse")
                        Text("123 Main St, City, State")
                    }
                    .font(.subheadline)
                    .foregroundColor(.blue)
                }
            }
            .padding()
            
            // MARK: - Tab Buttons
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(DetailTab.allCases, id: \.self) { tab in
                        Button(action: {
                            selectedTab = tab
                        }) {
                            Text(tab.rawValue)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(selectedTab == tab ? Color.blue : Color.clear)
                                .foregroundColor(selectedTab == tab ? Color.white : Color.blue)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.blue, lineWidth: selectedTab == tab ? 0 : 1)
                                )
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            Divider()
                .padding(.vertical, 5)
            
            // MARK: - Content Area Based on Selected Tab
            Group {
                switch selectedTab {
                case .feed:
                    TweetFeedView()  // Tweet-like feed view
                case .photos:
                    PhotosViewv()    // Placeholder photos view with camera integration
                case .tickets:
                    TicketsView()    // Centered placeholder for ticket sellers
                case .groups:
                    GroupsView()     // Centered placeholder for groups with "Make a Group" button
                }
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Event Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Function to open Apple Maps with a given address
    func openMapForAddress(_ address: String) {
        let addressEncoded = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: "http://maps.apple.com/?address=\(addressEncoded)") {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - TweetFeedView (Tweet-like Feed)

struct TweetFeedView: View {
    @State private var newPost: String = ""
    @State private var posts: [Post] = [
        Post(id: UUID(), text: "Excited for this event!", likes: 0, comments: 0),
        Post(id: UUID(), text: "Can't wait!", likes: 0, comments: 0),
        Post(id: UUID(), text: "Anyone else going?", likes: 0, comments: 0)
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            // Input field for a new tweet-like post.
            HStack {
                TextField("What's happening?", text: $newPost)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    if !newPost.isEmpty {
                        let newPostItem = Post(id: UUID(), text: newPost, likes: 0, comments: 0)
                        posts.insert(newPostItem, at: 0)
                        newPost = ""
                    }
                }) {
                    Text("Post")
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.bottom, 10)
            
            Divider()
            
            // Scrollable feed of posts
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(posts) { post in
                        PostView(post: post)
                    }
                }
            }
        }
    }
}

// Define a simple Post model for the tweet-like feed.
struct Post: Identifiable {
    let id: UUID
    let text: String
    var likes: Int
    var comments: Int
}

// A view that represents a single tweet-like post.
struct PostView: View {
    @State var post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Post text
            Text(post.text)
                .font(.body)
            
            // Buttons for Like and Comment (placeholders)
            HStack {
                Button(action: {
                    // Increment like count
                    post.likes += 1
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "heart")
                        Text("Like (\(post.likes))")
                    }
                }
                
                Spacer()
                
                Button(action: {
                    // Increment comment count
                    post.comments += 1
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "bubble.left")
                        Text("Comment (\(post.comments))")
                    }
                }
            }
            .font(.subheadline)
            .foregroundColor(.blue)
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(8)
    }
}

// MARK: - TicketsView (Centered Placeholder)

struct TicketsView: View {
    var body: some View {
        VStack {
            Text("Ticket Sellers")
                .font(.headline)
                .multilineTextAlignment(.center)
            Text("List of ticket sellers goes here.")
                .font(.body)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - GroupsView (Centered with 'Make a Group' Button)

struct GroupsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Find Your Group")
                .font(.headline)
                .multilineTextAlignment(.center)
            Text("Group listings and filters would go here.")
                .font(.body)
                .multilineTextAlignment(.center)
            Button(action: {
                // Action to create a new group
            }) {
                Text("Make a Group")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - PhotosViewv (Renamed Placeholder for Photos with Camera Integration)

struct PhotosViewv: View {
    @State private var isShowingCamera = false

    var body: some View {
        VStack {
            Text("Photos")
                .font(.headline)
            Button(action: {
                isShowingCamera = true
            }) {
                Text("Take Photo")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.vertical)
            // Horizontal scroll of placeholder images
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(0..<4) { _ in
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipped()
                            .cornerRadius(8)
                            .foregroundColor(.gray)
                            .background(Color.gray.opacity(0.2))
                    }
                }
            }
            Spacer()
        }
        .sheet(isPresented: $isShowingCamera) {
            // Present the camera using the ImagePicker below.
            ImagePicker()
        }
    }
}

// MARK: - ImagePicker Implementation

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // In a real app, you'd extract and use the selected image here.
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        // Use the camera if available, otherwise fall back to the photo library.
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

// MARK: - Preview

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample Event for preview purposes.
        let sampleEvent = Event(
            id: UUID(),
            banner: "sample_banner",  // Adjust if your Event model uses this property
            title: "Test Event",
            time: "7:00 PM"
        )
        NavigationView {
            EventDetailView(event: sampleEvent)
        }
    }
}
