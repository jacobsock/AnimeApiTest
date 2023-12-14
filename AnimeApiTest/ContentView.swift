//
//  ContentView.swift
//  AnimeApiTest
//
//  Created by Jacob M Sock  on 12/14/23.
//

import SwiftUI

import SwiftUI

struct AnimeData: Codable {
    let anime: String
    let character: String
    let quote: String
}

struct ContentView: View {
    @State private var animeData: AnimeData?

    var body: some View {
        VStack {
            Button("Fetch Anime Quote") {
                fetchAnimeData()
            }
            .padding()

            if let animeData = animeData {
                Text("Anime: \(animeData.anime)")
                Text("Character: \(animeData.character)")
                Text("Quote: \(animeData.quote)")
            }
        }
    }

    private func fetchAnimeData() {
        guard let url = URL(string: "https://animechan.xyz/api/random") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                let animeData = try decoder.decode(AnimeData.self, from: data)
                DispatchQueue.main.async {
                    self.animeData = animeData
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}



#Preview {
        ContentView()
    
}

