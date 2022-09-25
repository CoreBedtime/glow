//
//  ContentView.swift
//  glowapp
//
//  Created by bedtime on 9/25/22.
//

import SwiftUI
import Foundation



final class FavoritesStore: ObservableObject
{
    static let standard = FavoritesStore()

    @Published var favorites: [String] = ["Themes", "Install", "Config"]

    func add(_ favorite: String)
    {
        favorites.append(favorite)
    }
}

struct FavoritesView: View
{
    @ObservedObject var favoritesStore: FavoritesStore = .standard

    var body: some View
    {
        NavigationView
        {
            List(favoritesStore.favorites, id: \.self)
            { favorite in
                NavigationLink(favorite)
                {
                    FavoriteDetailView(favorite: favorite)
                }
            }.navigationTitle("GLOW")
        }
        .preferredColorScheme(.dark)
    }
}


func getFolderContentsURLs(_ folderPath: String) -> [URL]
{
    guard let contents = try? FileManager().contentsOfDirectory(atPath: folderPath) else { return [] }
    return contents.compactMap { URL.init(fileURLWithPath: $0) }
}

struct FavoriteDetailView: View
{
    let favorite: String

    var body: some View
    {
        
        if favorite == "Themes"
        {
            List
            {
                ForEach(0..<4)
                {_ in
                    Text("Theme")
                }
            }
        }
    }
}

