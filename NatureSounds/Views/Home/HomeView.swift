//
//  HomeView.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 02/09/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeVM:HomeViewModel
    @EnvironmentObject var musicVm:MusicPlayerViewModel
    @State private var isMusicPlayer  = false
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
                                isMusicPlayer = true
                            })
                                .padding(.vertical)
                            
                            RadnomCardView(action:{
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
                
            }.sheet(isPresented: $isMusicPlayer,onDismiss: {
                homeVM.loadAllCategory()
            }) {
                if let randomSong = homeVM.randomSong {
                    MusicPlayer(song:randomSong, image: "Rain")
                        .environmentObject(musicVm)
                }
               
            }
            
            
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
