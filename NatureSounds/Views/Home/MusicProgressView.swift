//
//  MusicProgressView.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 05/09/22.
//

import SwiftUI

struct MusicProgressView: View {
    @Binding var musicRunningTime:TimeInterval
    @Binding var songDuration:TimeInterval
    @Binding var progressBarValue:Double
    
    var body: some View {
        HStack {
            Text(musicRunningTime.minuteString())
            Slider(value: $progressBarValue)
                .foregroundColor(.btnColor)
                .progressViewStyle(.linear)
            
            Text(songDuration.minuteString())
        }
    }
}

struct MusicProgressView_Previews: PreviewProvider {
    static var previews: some View {
        MusicProgressView(musicRunningTime: .constant(0.0),songDuration: .constant(0.0),progressBarValue: .constant(0.50))
    }
}
