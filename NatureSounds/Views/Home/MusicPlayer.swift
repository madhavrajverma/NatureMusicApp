//
//  MusicPlayer.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 04/09/22.
//

import SwiftUI

struct MusicPlayer: View {
    @Environment(\.presentationMode) var presentaionMode
    let song:Song
    let image:String
    @EnvironmentObject var musicVm: MusicPlayerViewModel
    @StateObject var songDownload = MusicDownlaod()
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button(action : {
                        musicVm.stopPlayback()
                        presentaionMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "multiply.circle")
                            .font(.largeTitle)
                        
                    }
                    Spacer()
                    Button(action : {
                        
                    }) {
                        Image(systemName: "heart.fill")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                        
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
                    Text(song.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(image)
                        .font(.subheadline)
                        .fontWeight(.regular)
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(action : {}) {
                        Image(systemName: "backward.end.fill")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button(action : {
                      
                        if musicVm.status == .playing {
                            musicVm.pauseMusic()
                        } else if musicVm.status == .stopped {
                            musicVm.play(musicData: songDownload.data)
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
                                
                                if !self.songDownload.isDownloadComplete {
                                    LoadingView()
                                        .frame(width: 64, height: 64)
                                }
                            }
                    }
                    Spacer()
                    Button(action : {
                        
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
                songDownload.fetchSongAtUrl(song.url)
        }
            .onDisappear {
                musicVm.songDuration = 0
                musicVm.musicRunningTime  = 0
                musicVm.progressBarValue = 0
                musicVm.stop()
            }
        }
    }
}

struct MusicPlayer_Previews: PreviewProvider {
    static var previews: some View {
 MusicPlayer(song: Song(id: 3, name: "sea-beach", url: ""), image: "sea")
//     LoadingView()
    }
}




