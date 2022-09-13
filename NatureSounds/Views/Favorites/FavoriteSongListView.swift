//
//  FavoriteSongListView.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 09/09/22.
//

import Foundation
import SwiftUI

struct FavoriteSongListView:View {
  var song:FavoritesSongs
    var body: some View {
        HStack(alignment:.center,spacing:14) {
            Image(getImageName(Category: song.category))
                .resizable()
                .scaledToFill()
                .frame(width:40,height: 40)
                .clipped()
                .cornerRadius(4)
            
            VStack {
                Text(song.song.name)
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
