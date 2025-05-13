import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView() // Updated HomeView with categories
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            SearchView() // Placeholder for now
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            NotificationsView() // Placeholder for now
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("Notifications")
                }
            
            ProfileView() // Placeholder for now
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
