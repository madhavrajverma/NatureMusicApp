//
//  HomeViewModel.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 02/09/22.
//

import Foundation


class HomeViewModel: ObservableObject {
    
    @Published var categories : [Category] = []
    @Published var rainSongs : [Song] =  []
    @Published var rainSong: Song?
    
    @Published var randomCategory : Category?
    @Published var randomSongsList:[Song] = []
    @Published var randomSong: Song?
    @Published var randomIndex: Int = 0
    
    @Published var allSongs:[Song] = []
    @Published var filteredSong:[Song] = []
    
    func loadAllCategory() {
        let categories: [Category] = Bundle.main.decode("songs.json")
        self.categories = categories
        
        if(!self.categories.isEmpty) {
            loadRainSongs(categories: categories)
            loadRandomSonglist(categoreis: categories)
        }
        let index = categories.endIndex
        print(index)
        
        if(allSongs.isEmpty) {
            for category in categories {
                for song in category.songs {
                    self.allSongs.append(song)
                }
            }
        }
        
    }
    
    func loadRainSongs(categories:[Category]) {
        
            let rainCategory =  self.categories.filter { $0.Category == "Rain"}
            if let rainSongs = rainCategory.first?.songs {
                self.rainSongs = rainSongs
            }
        
          self.rainSong = self.rainSongs[0]
        
    }
    
    func loadRandomSonglist(categoreis:[Category]) {
        
        let randomCategoryIndex = Int.random(in: 1..<categories.count)
        let randomCategory = categoreis[randomCategoryIndex]
        self.randomCategory = randomCategory

        self.randomSongsList = randomCategory.songs
        
        let randomIndex = Int.random(in: 0..<self.randomSongsList.count)
        self.randomSong = self.randomSongsList[randomIndex]

    }

}

