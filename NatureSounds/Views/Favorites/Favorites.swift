//
//  Favorites.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 04/09/22.
//

import SwiftUI

struct Favorites: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical,showsIndicators: false){
                
                
                TitleView(title: "Playlists")
                    .padding(.bottom)
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(spacing :20) {
                        ForEach(0..<5) { _ in
                                PlaylistView()
                        }
                    }
                   
                }
                
                
                TitleView(title: "Music")
                    .padding(.vertical)
                
                ScrollView(.vertical,showsIndicators: false) {
                    
                    VStack(spacing :20) {
                        ForEach(0..<5) { _ in
                            FavoriteSongListView()
                             Divider()
                        }
                    }
                } .padding(.bottom,100)
                
            }
            .padding()
           
            .navigationTitle("Favorites")
        }
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
    }
}

