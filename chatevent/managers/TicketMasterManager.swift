import Foundation

class TicketMasterManager: ObservableObject {
    @Published var events: [TicketEvent] = []

    func fetchDallasEvents(classification: String) {
        let apiKey = "9MWFx6BTXIqqw9TxbLQLZ9icYirz1LQK"
        let city = "Dallas"
        let latLon = "32.7767,-96.7970" // Latitude and Longitude for Dallas
        let radius = "30" // Radius in miles
        let unit = "miles" // Unit for the radius
        let startDate = ISO8601DateFormatter().string(from: Date()) // Current date
        let twoMonthsLater = Calendar.current.date(byAdding: .month, value: 2, to: Date())!
        let endDate = ISO8601DateFormatter().string(from: twoMonthsLater) // Date two months later

        // Build the URL string with optional startDate and endDate
        var urlString = """
        https://app.ticketmaster.com/discovery/v2/events.json?apikey=\(apiKey)&city=\(city)&classificationName=\(classification)&latlong=\(latLon)&radius=\(radius)&unit=\(unit)&sort=date,asc
        """

        // Add date filters if needed
//        urlString += "&startDateTime=\(startDate)&endDateTime=\(endDate)"
        
//        urlString += "&sort=date,asc"

        // Create the URL
        guard let url = URL(string: urlString) else { return }

        // Network request
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(EventResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.events = decoded.embedded?.events ?? []
                        print(self.events)
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            } else if let error = error {
                print("Network error: \(error)")
            }
        }.resume()
    }
}
