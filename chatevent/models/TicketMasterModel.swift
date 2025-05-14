import Foundation

struct EventResponse: Codable {
    let embedded: EmbeddedEvents?

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}

struct EmbeddedEvents: Codable {
    let events: [TicketEvent]
}

struct TicketEvent: Codable { // name and date
    let name: String
    let type: String
    let id: String
    let url: String
    let dates: EventDates
    let images: [EventImages]
}

struct EventDates: Codable {
    let start: EventStart
}

struct EventStart: Codable {
    let localDate: String?
    let localTime: String?
}

struct EventImages: Codable {
    var ratio: Double?
    let url: String
    let width: Int
    let height: Int
    let fallback: Bool

    private enum CodingKeys: String, CodingKey {
        case ratio
        case url
        case width
        case height
        case fallback
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // Attempt to decode the ratio as a string, then convert it to Double
        if let ratioString = try? values.decode(String.self, forKey: .ratio) {
            self.ratio = Double(ratioString)
        } else {
            self.ratio = try? values.decode(Double.self, forKey: .ratio)
        }

        self.url = try values.decode(String.self, forKey: .url)
        self.width = try values.decode(Int.self, forKey: .width)
        self.height = try values.decode(Int.self, forKey: .height)
        self.fallback = try values.decode(Bool.self, forKey: .fallback)
    }
}
