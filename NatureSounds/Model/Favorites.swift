//
//  Favorites.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 14/09/22.
//

import Foundation

struct FavoritesCategory: Codable {
    var category:Category
    var isFavorite:Bool
}


struct FavoritesSongs:Codable {
    var song:Song
    var isFavorite:Bool
    var category:String
}
