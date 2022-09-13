//
//  ContentView.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 31/08/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                }
            FavoritesScreen()
                .tabItem {
                    VStack {
                        Image(systemName: "heart")
                        Text("Favorites")
                    }
                }
        }
        .overlay(
            VStack {
                Spacer()
                MusicStatusBarView()
                    .padding(.bottom, 48)
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
