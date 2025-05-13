import Foundation
import SwiftUI

struct Event: Identifiable {
    let id: UUID
    let banner: String  // New property for the banner image name or URL
    let title: String
    let time: String
    // Optionally, if you use photos:
    // let photos: [Photo]
}

struct Photo: Identifiable {
    let id: UUID
    let banner: Image
}
