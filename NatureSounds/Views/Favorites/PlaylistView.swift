//
//  PlaylistView.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 09/09/22.
//

import SwiftUI

struct PlaylistView: View {
    var body: some View {
        VStack(alignment:.leading){
            Image("rain")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(minWidth: 120, maxWidth: 120, minHeight: 100, maxHeight: 120)
                 .clipped()
                 .cornerRadius(10)
            Text("Rain")
                .font(.title3)
                .fontWeight(.semibold)
        }
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView()
    }
}
