//
//  FavoritesViewModel.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 09/09/22.
//

import Foundation

class FavoritesViewModel : ObservableObject {
    
    @Published var favoritesPlaylists: [FavoritesCategory]  = []
    @Published var favoritesSongs : [FavoritesSongs] = []
    
    let favoritesDataManager = FavoriteDataManger.instance
    
    func loadFavoritesPlaylist () {
        favoritesDataManager.loadCategoryData { result in
            switch result {
            case .success(let favoritesPlaylist):
                DispatchQueue.main.async {
                    self.favoritesPlaylists = favoritesPlaylist
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func checkPlaylistAlreadyInFavorites(category:Category) {
        let index = favoritesPlaylists.firstIndex { $0.category.id ==  category.id }
        if let index = index {
            favoritesPlaylists.remove(at: index)
            saveToFavoritePlaylist()
        }else {
            saveToFavoritePlaylist(category: category)
            loadFavoritesPlaylist()
        }
    }
    
   
    func isCategoryInfavorite(category:Category) -> Bool {
        let index = favoritesPlaylists.firstIndex { $0.category.id ==  category.id }
        guard let _ = index else {
            return false
        }
        return true
    }
    
    func saveToFavoritePlaylist() {
        favoritesDataManager.saveFavoritesPlayList(favoritesPlaylist: self.favoritesPlaylists)
    }
    
    func saveToFavoritePlaylist(category:Category) {
        let favoritesCategory = FavoritesCategory(category: category, isFavorite: true)
        favoritesPlaylists.append(favoritesCategory)
        favoritesDataManager.saveFavoritesPlayList(favoritesPlaylist: self.favoritesPlaylists)
    }
    
    func checkSongAlreadyInFavorites(song:Song,category:String) {
        let index = self.favoritesSongs.firstIndex { $0.song.id  == song.id }

        if let index = index {
            favoritesSongs.remove(at: index)
            saveToFavoriteSongs()
        }else {
            saveToFavoriteSongs(song: song,category: category)
            loadFavoritesSongs()
        }
    }
    
    func isSongInfavorite(song:Song) -> Bool {
        let index = self.favoritesSongs.firstIndex { $0.song.id  == song.id }
        guard let _ = index else {
            return false
        }
        return true
    }
    
    
    func loadFavoritesSongs() {
        favoritesDataManager.loadFavoritesSong{ result in
            switch result {
            case .success(let favoriteSongs):
                DispatchQueue.main.async {
                    self.favoritesSongs = favoriteSongs
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func saveToFavoriteSongs() {
        favoritesDataManager.saveFavoriteSong(songs: self.favoritesSongs)
    }
    
    func saveToFavoriteSongs(song:Song,category:String) {
        let favoriteSong = FavoritesSongs(song: song, isFavorite: true, category: category)
        self.favoritesSongs.append(favoriteSong)
        favoritesDataManager.saveFavoriteSong(songs: self.favoritesSongs)
    }
    
 
    
}
