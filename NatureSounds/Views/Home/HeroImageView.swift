//
//  HeroImageView.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 02/09/22.
//

import SwiftUI

struct HeroImageView: View {
    let imageName:String
    let title:String
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth:.infinity)
                .cornerRadius(20)
                .overlay(
                    VStack(alignment:.trailing){
                        HStack {
                            Text(title)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        Spacer()
                        
                        HStack {
                            Spacer()
                            Button(action: {}) {
                                Text("🎧 Start")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(height:40)
                                    .padding(.horizontal)
                                    .background(Color.btnColor.cornerRadius(10))
                            }
                            Spacer()
                        }
                    }
                    .padding()
                    
                )            
        }
    }
}

struct HeroImageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeroImageView(imageName: "rain",title: "Rain Sounds")
            
        }
    }
}
