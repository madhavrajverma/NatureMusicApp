//
//  FavoriteDataManager.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 14/09/22.
//

import Foundation

class FavoriteDataManger: ObservableObject {
    
    static let instance = FavoriteDataManger()
    
    private init( ) { }
    
    let favoritesJsonURL = URL(fileURLWithPath: "favoritesCategories",
                               relativeTo: FileManager.documentDirectoryURL).appendingPathExtension("json")
    
    let favoritesSongJsonURL = URL(fileURLWithPath: "favoritesSongJsonURL",
                               relativeTo: FileManager.documentDirectoryURL).appendingPathExtension("json")
    
    func loadCategoryData(completion: @escaping (Result<[FavoritesCategory],Error>) -> Void) {
        let decoder  = JSONDecoder()
             do {
                 let tasksData = try Data(contentsOf: favoritesJsonURL)
                 let favoritesCategories = try decoder.decode([FavoritesCategory].self, from: tasksData)
                 completion(.success(favoritesCategories))
             }catch let error {
                 print(error)
             }
    }
    
    func saveFavoritesPlayList(favoritesPlaylist:[FavoritesCategory]) {
            
            let encoder  = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            do {
                let taskData = try encoder.encode(favoritesPlaylist)
                try taskData.write(to: favoritesJsonURL,options: .atomicWrite)
                    
            }catch let error {
                print(error)
            }
    }
    
    func saveFavoriteSong(songs:[FavoritesSongs]) {
        let encoder  = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let taskData = try encoder.encode(songs)
            try taskData.write(to: favoritesSongJsonURL,options: .atomicWrite)
                
        }catch let error {
            print(error)
        }
    }
    
    
    func loadFavoritesSong(completion: @escaping (Result<[FavoritesSongs],Error>) -> Void) {
        let decoder  = JSONDecoder()
             do {
                 let tasksData = try Data(contentsOf: favoritesSongJsonURL)
                 let favoritesCategories = try decoder.decode([FavoritesSongs].self, from: tasksData)
                 completion(.success(favoritesCategories))
             }catch let error {
                 print(error)
             }
    }
    
}
