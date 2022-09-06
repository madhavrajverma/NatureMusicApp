//
//  RadnomCardView.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 02/09/22.
//

import SwiftUI

struct RadnomCardView: View {
    let action: () -> Void
    var body: some View {
        VStack {
            ZStack(alignment:.topLeading){
                Image("background")
                    .resizable()
                    .frame(height:100)
                HStack {
                    VStack(alignment:.leading,spacing: 6) {
                        Text("Random Play")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("SOUND")
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding()
                    Spacer()
                    
                    Button(action: {
                        action()
                    }) {
                        Image(systemName: "play.circle")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(50)
                            
                    }
                    .padding(.horizontal)
                }
               
            }.frame(height:100)
        }
        .cornerRadius(12)
    }
}

struct RadnomCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RadnomCardView {
                
            }
        }
    }
}
