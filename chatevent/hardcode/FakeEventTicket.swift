//
//  FakeEventTicket.swift
//  chatevent
//
//  Created by Joshua Hodgson on 5/14/25.
//

struct FakeEventTicket {
     let SportEvent = TicketEvent(
        name: "Team1 vs Team2",
        type: "sports",
        id: "23efgy",
        url: "https://www.ticketmaster.com/discover/sports",
        dates: EventDates(
            start: EventStart(
                localDate:"2025-05-21",
                localTime:"19:00:00")),
        images: [EventImages(
            ratio: 0,
            url:"https://png.pngtree.com/thumb_back/fh260/back_pic/04/07/48/465811cc88e057c.jpg",
            width:1024,
            height:576,
            fallback:false)]
    )
    
    let MusicEvent = TicketEvent(
        name: "Awesome Artist",
        type: "music",
        id: "6yhj9",
        url: "https://www.ticketmaster.com/discover/concerts",
        dates: EventDates(
            start: EventStart(
                localDate:"2025-05-21",
                localTime:"19:00:00")),
        images: [EventImages(
            ratio: 0,
            url:"https://hokiesports.com/imgproxy/XXtjm4langLORpfdBjAhbTuIzR6uVYyQ0daAlkrtU2w/rs:fit:1980:0:0/g:ce/q:90/aHR0cHM6Ly9zdG9yYWdlLmdvb2dsZWFwaXMuY29tL3ZpcmdpbmlhdGVjaC1wcm9kLzIwMjUvMDUvMDYvNG0wR0hiSGdzSTZzRzBLZkNBejlLWDh6WTBFVkNNZnFOTDlYZllVUC5wbmc.png",
            width:1024,
            height:576,
            fallback:false
        )]
    )

}
    
