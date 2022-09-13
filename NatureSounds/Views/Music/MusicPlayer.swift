//
//  MusicPlayer.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 04/09/22.
//

import SwiftUI

struct MusicPlayer: View {
    @Environment(\.presentationMode) var presentaionMode
    let image:String
    @EnvironmentObject var musicVm: AudioPlayerViewModel
    @EnvironmentObject var favoritesVm:FavoritesViewModel
    @State private var isFavorite:Bool = false
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button(action : {

                        presentaionMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "multiply.circle")
                            .font(.largeTitle)
                        
                    }
                    Spacer()
                    Button(action : {
                        guard let song = musicVm.currentSong, let category = musicVm.category else {
                            return
                        }
                    
                        favoritesVm.checkSongAlreadyInFavorites(song:song,category:category)
                        self.isFavorite = favoritesVm.isSongInfavorite(song: song)
                       
                    }) {
                        Image(systemName : isFavorite ?  "heart.fill" :"heart")
                            .font(.largeTitle)
                            .foregroundColor( .red)
                        
                    }
                }
                .padding()
                Image(getImageName(Category: image))
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth:.infinity)
                    .cornerRadius(10)
                    .padding()
                   
                VStack(spacing:10){
                    Text(musicVm.currentSong?.name ?? "No Name")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(image)
                        .font(.subheadline)
                        .fontWeight(.regular)
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(action : {
                        musicVm.prevSong()
                    }) {
                        Image(systemName: "backward.end.fill")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button(action : {
                        
                        if musicVm.status == .playing {
                            musicVm.pauseMusic()
                        } else if musicVm.status == .stopped {
                            musicVm.play(musicData: musicVm.musicData)
                        }else if musicVm.status == .pause {
                            musicVm.resumeMusic()
                        }
                        
                    }) {
                            ZStack {
                                Image(systemName: musicVm.status == .playing ?  "pause.fill":"play.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.btnColor)
                                    .padding()
                                    .background(Color.white.cornerRadius(50))
                                
                                if !self.musicVm.isSongDownloadCompleted {
                                    LoadingView()
                                        .frame(width: 64, height: 64)
                                }
                            }
                    }
                    Spacer()
                    
                    Button(action : {
                        musicVm.nextSong()
                    }) {
                        Image(systemName: "forward.end.fill")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                Spacer()
                
                MusicProgressView(musicRunningTime: $musicVm.musicRunningTime, songDuration: $musicVm.songDuration, progressBarValue: $musicVm.progressBarValue)
                    .padding()
            }
            .onAppear {
                
                if(musicVm.currentSong == nil) {
                    musicVm.playMusicDataFromURL()
                    musicVm.setupRemoteTransportControls()
                    musicVm.setupNowPlaying()
                }
                guard let song = musicVm.currentSong, let category = musicVm.category else {
                    return
                }
            
                self.isFavorite = favoritesVm.isSongInfavorite(song: song)
           }
        }
    }
}

//struct MusicPlayer_Previews: PreviewProvider {
//    static var previews: some View {
//// MusicPlayer(song: Song(id: 3, name: "sea-beach", url: ""), image: "sea")
////     LoadingView()
//    }
//}




