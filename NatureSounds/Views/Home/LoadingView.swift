//
//  LoadingView.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 05/09/22.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    @State private var isLoading = false
    var body: some View{
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(Color.btnColor, lineWidth: 6)
            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
            .onAppear() {
                withAnimation(Animation.linear(duration: 0.6).repeatForever(autoreverses: false)) {
                    self.isLoading = true
                }
            }
    }
}
