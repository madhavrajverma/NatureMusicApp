//
//  FavoritesViewModel.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 09/09/22.
//

import Foundation


class FavoritesViewModel : ObservableObject {
    
    @Published var favoritesPlaylists: [Category]  = []
    @Published var favoritesSongs : [Song] = []
    
    func loadFavoritesPlaylist () {
        
    }
    
    func loadFavoritesSongs() {
        
    }
    
    func saveToFavoritePlaylist() {
        
    }
    
    func saveToFavoriteSongs() {
        
    }
    
}
