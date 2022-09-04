//
//  TimeInterval+Extension.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 05/09/22.
//

import Foundation



extension TimeInterval {
    func minuteString()  -> String {
        let minute = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        
        return String(format: "%02i:%02i", minute,seconds)
    }
}
