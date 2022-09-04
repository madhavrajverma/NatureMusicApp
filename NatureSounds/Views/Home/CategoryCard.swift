//
//  CategoryCard.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 02/09/22.
//

import SwiftUI

struct CategoryCard: View {
    let Category:String
    var body: some View {
        VStack(alignment:.leading,spacing: 10) {
            Image(getImageName(Category: Category))
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
            
            VStack(alignment:.leading,spacing: 8) {
                
                Text(Category)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.textColor)
                
                Text("Music")
                    .font(.title3)
                    .foregroundColor(.black)
                    
            }
        }
    }
}

struct CategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCard(Category: "Meditation")
            .previewLayout(.sizeThatFits)
    }
}
