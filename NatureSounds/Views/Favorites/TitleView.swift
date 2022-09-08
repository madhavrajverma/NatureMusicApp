//
//  TitleView.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 09/09/22.
//

import SwiftUI

struct TitleView:View {
    let title:String
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer()
        }
    }
}


struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "Playlist")
    }
}
