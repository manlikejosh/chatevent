import Foundation

class TicketMasterManager: ObservableObject {
    @Published var events: [TicketEvent] = []

    func fetchDallasSportsEvents() {
        let apiKey = "9MWFx6BTXIqqw9TxbLQLZ9icYirz1LQK"
        let city = "Dallas"
        let classification = "sports"
        let startDate = ISO8601DateFormatter().string(from: Date())
        let twoMonthsLater = Calendar.current.date(byAdding: .month, value: 2, to: Date())!
        let endDate = ISO8601DateFormatter().string(from: twoMonthsLater)

        let urlString = """
        https://app.ticketmaster.com/discovery/v2/events.json?apikey=\(apiKey)&city=\(city)&classificationName=\(classification)&startDateTime=\(startDate)&endDateTime=\(endDate)
        """

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(EventResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.events = decoded.embedded?.events ?? []
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
