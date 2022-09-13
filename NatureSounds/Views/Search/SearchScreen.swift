//
//  SearchScreen.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 14/09/22.
//

import SwiftUI

struct SearchScreen: View {
    @EnvironmentObject var homeVm: HomeViewModel
    @State private var query: String = ""
    @EnvironmentObject var musicVm :AudioPlayerViewModel
    @State private var isMusicPlayer = false
    @State private var category:String = ""
    var body: some View {
        
        if #available(iOS 15.0, *) {
            NavigationView {
                VStack {
                    if searchResults.isEmpty {
                        Image("search")
                            .resizable()
                            .scaledToFill()
                    }else {
                        List {
                            ForEach(searchResults,id:\.id) { song  in
                                SearchSongResult(song: song)
                                    .onTapGesture {
                                        self.category = song.category
                                        musicVm.currentSong = song
                                        isMusicPlayer = true
                                        musicVm.playMusicDataFromURL()
                                    }
                                    .frame(height:60)
                            }
                        }
                        .listStyle(.plain)
                    }
                }
                .sheet(isPresented: $isMusicPlayer) {
                    MusicPlayer(image:category)
                        .environmentObject(musicVm)
                }
                .navigationTitle("Search")
                .searchable(text: $query, placement: .automatic, prompt: Text("Search"))
            }
        } else {
            // Fallback on earlier versions
        }
       
    }
    
    var searchResults: [Song] {
          if query.isEmpty {
              return []
          } else {
              return homeVm.allSongs.filter{$0.name.lowercased().contains(query.lowercased())}
          }
      }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}



struct SearchSongResult:View {
   var song:Song
    var body: some View {
        HStack(alignment:.center,spacing:14) {
            Image(getImageName(Category: song.category))
                .resizable()
                .scaledToFill()
                .frame(width:40,height: 40)
                .clipped()
                .cornerRadius(4)
            
            VStack {
                Text(song.name)
                    .font(.title2)
                    .fontWeight(.regular)
                
            }
            Spacer()
            
            Image(systemName: "play.fill")
                .font(.headline)
                .foregroundColor(.btnColor)
                .padding(.trailing)
        }
    }
}
