//
//  Favorites.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 04/09/22.
//

import SwiftUI

struct FavoritesScreen: View {
    @EnvironmentObject var favoriteVm: FavoritesViewModel
    @EnvironmentObject var musicVm :AudioPlayerViewModel
    @State private var isMusicPlayer = false
    @State private var category:String = ""
    var body: some View {
        NavigationView {
            ScrollView(.vertical,showsIndicators: false){
                
                
                TitleView(title: "Playlists")
                
                    .padding(.bottom)
                if favoriteVm.favoritesPlaylists.isEmpty {
                    Image("noplaylist")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.size.width - 40)
                }else {
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack(spacing :20) {
                                ForEach(favoriteVm.favoritesPlaylists,id:\.category.id) { category in
                                    NavigationLink(destination: CategorySongsView(Category: category.category)) {
                                        PlaylistView(category: category)
                                    }

                                }
                        }
                    }
                }
                TitleView(title: "Music")
                    .padding(.vertical)
                
                if favoriteVm.favoritesSongs.isEmpty {
                    Image("noSongs")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.size.width - 40)
                }else {
                    ScrollView(.vertical,showsIndicators: false) {
                        
                        VStack(spacing :20) {
                            ForEach(favoriteVm.favoritesSongs,id:\.song.id) { favoriteSong in
                                FavoriteSongListView(song:favoriteSong)
                                    .onTapGesture {
                                        self.category = favoriteSong.category
                                        musicVm.currentSong = favoriteSong.song
                                        isMusicPlayer = true
                                        musicVm.playMusicDataFromURL()
                                    }
                                 Divider()
                            }
                        }
                    } .padding(.bottom,100)
                }
                
            }
            .onAppear(perform: {
                favoriteVm.loadFavoritesPlaylist()
                favoriteVm.loadFavoritesSongs()
            })
            .sheet(isPresented: $isMusicPlayer) {
                MusicPlayer(image: self.category)
                    .environmentObject(musicVm)
            }
            .padding()
           
            .navigationTitle("Favorites")
        }
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesScreen()
    }
}
