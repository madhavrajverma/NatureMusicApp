//
//  PlaylistView.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 09/09/22.
//

import SwiftUI

struct PlaylistView: View {
    var category : FavoritesCategory
    var body: some View {
        VStack(alignment:.leading){
            Image(getImageName(Category: category.category.Category))
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(minWidth: 120, maxWidth: 120, minHeight: 100, maxHeight: 120)
                 .clipped()
                 .cornerRadius(10)
            Text("\(category.category.Category)")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.black)
        }
    }
}

//struct PlaylistView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistView()
//    }
//}
