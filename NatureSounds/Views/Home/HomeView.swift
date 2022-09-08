//
//  HomeView.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 02/09/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeVM:HomeViewModel
//    @StateObject var musicVM = MusicPlayerViewModel()
    @EnvironmentObject var musicVM: AudioPlayerViewModel
    @State private var isMusicPlayer  = false
    @State private var category = "Rain"
    var body: some View {
        NavigationView {
            ZStack(alignment:.bottom){
                ScrollView(.vertical,showsIndicators: false) {
                        VStack(alignment:.leading) {
                            HStack {
                                MainTitleView()
                                Spacer()
                            }
                            .padding(.vertical,20)
                            
                            HeroImageView(imageName: "rain", title: "Rain Sound", action: {
                                
                                category = "Rain"
                                if let rainSong = homeVM.rainSong{
                                    updateDataForMusicplayer(song: rainSong, category: "Rain", songList: homeVM.rainSongs, currentIndex: 0)
                                }
                                musicVM.category = "Rain"
                                musicVM.playMusicDataFromURL()
                                isMusicPlayer = true
                            })
                                .padding(.vertical)
                            
                            RadnomCardView(action:{
                                category = homeVM.randomCategory?.Category ?? ""
                                
                                if let raindomSong = homeVM.randomSong ,
                                   let category = homeVM.randomCategory{
                                    updateDataForMusicplayer(song: raindomSong,category: category.Category, songList: homeVM.randomSongsList, currentIndex: homeVM.randomIndex)
                                }
                                musicVM.playMusicDataFromURL()
                                isMusicPlayer = true
                            })
                            
                            HStack {
                                Text("Music Playlists")
                                    .font(.title3)
                                    .fontWeight(.bold)
                            }
                            .padding(.vertical)
                            
                            CategoryListView(categories:homeVM.categories)
                              
                        }
                    }.padding([.leading,.trailing])
                        .navigationTitle("Nature 🎵 Sounds")
                        .navigationBarTitleDisplayMode(.inline)
                        .onAppear {
                            homeVM.loadAllCategory()
                    }
                
            }.sheet(isPresented: $isMusicPlayer) {
                if homeVM.randomSong != nil {
                    MusicPlayer(image:category)
                        .environmentObject(musicVM)
                }
               
            }
            
            
        }
        .environmentObject(musicVM)
     
    }
    
    func updateDataForMusicplayer(song:Song,category:String,songList:[Song],currentIndex:Int) {
        musicVM.songList = songList
        musicVM.currentSong = song
        musicVM.currentIndex = currentIndex
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
