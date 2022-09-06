//
//  Date+Extension.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 07/09/22.
//

import Foundation

extension Date {
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
}
