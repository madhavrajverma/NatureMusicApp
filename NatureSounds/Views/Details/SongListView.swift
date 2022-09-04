//
//  SongListView.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 04/09/22.
//

import SwiftUI

struct SongListView: View {
    let song:Song
    var body: some View {
        HStack(alignment:.center,spacing:14) {
            Image(systemName: "play")
                .font(.title2)
                .foregroundColor(.white)
                .frame(width:40,height: 40)
                .background(Color.btnColor.cornerRadius(50))
            
            VStack {
                Text(song.name)
                    .font(.title2)
                    .fontWeight(.regular)
            }
            Spacer()
        }
        .padding()
    }
}

struct SongListView_Previews: PreviewProvider {
    static var previews: some View {
        SongListView(song: Song(id: 1, name: "Beach Music", url: ""))
          
    }
}
