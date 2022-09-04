//
//  HomeView.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 02/09/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeVM:HomeViewModel
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
                            
                            HeroImageView(imageName: "rain", title: "Rain Sound")
                                .padding(.vertical)
                            
                            RadnomCardView()
                            
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
                
            }
            
            
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
