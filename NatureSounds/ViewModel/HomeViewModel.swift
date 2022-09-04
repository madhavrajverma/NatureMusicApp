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
    
    
    func loadAllCategory() {
        
        let categories: [Category] = Bundle.main.decode("songs.json")
        self.categories = categories
        
        if(!self.categories.isEmpty) {
            let rainCategory =  self.categories.filter { $0.Category == "Rain"}
            if let rainSongs = rainCategory.first?.songs {
                self.rainSongs = rainSongs
            }
        }
    }
}
