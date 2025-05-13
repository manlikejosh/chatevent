//
//  PhotoDetailView.swift
//  eventchat
//
//  Created by Eliyan Memon on 1/18/25.
//


import SwiftUI

struct PhotoDetailView: View {
let photo: Photo

var body: some View {
    VStack {
        Image(systemName: "photo") // Placeholder for the actual image
            .resizable()
            .scaledToFit()
            .frame(maxHeight: 300)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(8)

        // Using a placeholder for likes since Photo doesn't have a likes property
        Text("Likes: 0")
            .font(.headline)
            .padding()

        Spacer()
    }
    .padding()
}
}
