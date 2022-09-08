//
//  MusicStatusBarView.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 09/09/22.
//

import SwiftUI

struct MusicStatusBarView: View {
    @EnvironmentObject var audioPlayerViewModel: AudioPlayerViewModel
    @Environment(\.colorScheme) var colorSchema
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
                    .font(.subheadline)
                    .foregroundColor(colorSchema == .dark ? .white : .black)
                Spacer()
                
                HStack(spacing:30){
                    
                    Button(action : {
                        if audioPlayerViewModel.status == .playing {
                            audioPlayerViewModel.pauseMusic()
                        }else if audioPlayerViewModel.status == .pause {
                            audioPlayerViewModel.resumeMusic()
                        }
                    }){
                        ZStack {
                            Image(systemName: audioPlayerViewModel.status == .playing ?  "pause.fill":"play.fill")
                                .font(.title)
                                .foregroundColor(.btnColor)
                            
                            if !self.audioPlayerViewModel.isSongDownloadCompleted && audioPlayerViewModel.currentSong != nil {
                                LoadingView()
                                    .frame(width: 50, height: 50)
                            }
                            
                        }
                        
                       
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
            .background(Color("Background"))
        }
        .buttonStyle(CustomButton())
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

struct CustomButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
    }
}
