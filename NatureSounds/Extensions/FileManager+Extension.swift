//
//  FileManager+Extension.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 14/09/22.
//

import Foundation

public extension FileManager {
   static var  documentDirectoryURL:URL {
       `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
