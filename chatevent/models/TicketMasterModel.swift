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
    let dates: EventDates
}

struct EventDates: Codable {
    let start: EventStart
}

struct EventStart: Codable {
    let localDate: String?
    let localTime: String?
}
