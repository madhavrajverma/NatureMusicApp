//
//  MainTitleView.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 02/09/22.
//

import SwiftUI

struct MainTitleView: View {
    var body: some View {
        VStack(alignment:.leading,spacing: 6) {
            Text("Good Morning, Madhav")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color.mainTextColor)
            
            Text("We Wish you have a good day")
                .font(.body)
                .fontWeight(.regular)
        }
    }
}

struct MainTitleView_Previews: PreviewProvider {
    static var previews: some View {
        MainTitleView()
    }
}
