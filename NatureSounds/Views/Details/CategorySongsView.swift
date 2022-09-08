//
//  CategorySongsView.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 04/09/22.
//

import SwiftUI

struct CategorySongsView: View {
    let Category: Category
    @Environment(\.presentationMode) var presentaionMode
    @EnvironmentObject var musicVm :AudioPlayerViewModel
//    @StateObject var musicVm = MusicPlayerViewModel()
    @State  var isMusicPlayer = false
    @State var song:Song?
    var body: some View {
            ScrollView(.vertical,showsIndicators: false) {
                VStack {
                    GeometryReader { geo in
                        ZStack(alignment:.top){
                            VStack {
                                 if geo.frame(in: .global).minY <= 0 {
                                    Image(getImageName(Category: Category.Category))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width:geo.size.width,height:geo.size.height)
                                        .offset(y: geo.frame(in: .global).minY/9)
                                        .clipped()
                                 }else {
                                     Image(getImageName(Category: Category.Category))
                                         .resizable()
                                         .aspectRatio(contentMode: .fill)
                                         .frame(width: geo.size.width, height: geo.size.height + geo.frame(in: .global).minY)
                                         .clipped()
                                         .offset(y: -geo.frame(in: .global).minY)
                                 }
                               
                            }
                            HStack {
                                Button(action : {
                                    presentaionMode.wrappedValue.dismiss()
                                }) {
                                    Image(systemName: "arrow.left")
                                        .font(.title)
                                        .frame(width:50,height: 50)
                                        .background(Color.btnColor)
                                        .foregroundColor(.white)
                                        .clipped()
                                        .cornerRadius(50)
                                }
                                
                                Spacer()
                                Image(systemName: "heart.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.red)
                            }
                            .padding()
                            .padding(.top,20)
                        }
                    }.frame(height:300)
                    
                    HStack {
                        VStack(alignment:.leading,spacing: 14) {
                            Text(Category.Category)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Text("Ease the mind into a restful night’s sleep  with these deep, amblent tones.")
                                .font(.body)
                                .fontWeight(.regular)
                            
                        }
                        Spacer()
                    }
                    .padding(.leading)
                    
                    Divider()
                        .padding(.bottom
                        )
                    ForEach(Category.songs,id:\.id) { song in
                        SongListView(song:song)
                            .onTapGesture {
                                self.song = song
                                musicVm.currentSong  = song
                                musicVm.currentIndex = Category.songs.firstIndex(where: { s in
                                    song.name == s.name
                                }) ?? 0
                                musicVm.category = Category.Category
                                isMusicPlayer = true
                                musicVm.playMusicDataFromURL()
                            }
                        Divider()
                    }
                    
                }
                .padding(.bottom,100)
                
            }
            .onAppear(perform: {
                musicVm.updateSongList(songs: Category.songs)
            })
            .sheet(isPresented: $isMusicPlayer) {
                    MusicPlayer(image: Category.Category)
                    .environmentObject(musicVm)
            }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}


//struct CategorySongsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategorySongsView()
//    }
//}


