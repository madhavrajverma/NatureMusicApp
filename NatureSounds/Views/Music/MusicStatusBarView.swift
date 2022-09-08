//
//  MusicStatusBarView.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 09/09/22.
//

import SwiftUI

struct MusicStatusBarView: View {
    @EnvironmentObject var audioPlayerViewModel: AudioPlayerViewModel
    var body: some View {
        let song = audioPlayerViewModel.currentSong
        Button(action :{
            self.audioPlayerViewModel.ShowPlayer()
        }){
            HStack {
                Image(getImageName(Category: audioPlayerViewModel.category ?? "empty"))
                    .resizable()
                    .frame(width: 48, height: 48)
                    .cornerRadius(10)
                Text(song?.name ?? "")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                
                HStack(spacing:30){
                    Button(action : {
                        if audioPlayerViewModel.status == .playing {
                            audioPlayerViewModel.pauseMusic()
                        }else if audioPlayerViewModel.status == .pause {
                            audioPlayerViewModel.resumeMusic()
                        }
                    }){
                        Image(systemName: audioPlayerViewModel.status == .playing ?  "pause.fill":"play.fill")
                            .font(.title)
                            .foregroundColor(.btnColor)
                    }
                    
                    Button(action : {
                        audioPlayerViewModel.nextSong()
                    }) {
                        Image(systemName: "forward.fill")
                            .font(.title)
                             .foregroundColor(.btnColor)
                    }
                }
            }
            .padding()
            .background(Color.white.opacity(0.9))
        }
        .sheet(isPresented: $audioPlayerViewModel.isShowPlayer) {
            MusicPlayer(image: audioPlayerViewModel.category ?? "")
                .environmentObject(audioPlayerViewModel)
        }
    }
}

struct MusicStatusBarView_Previews: PreviewProvider {
    static var previews: some View {
        MusicStatusBarView()
    }
}
