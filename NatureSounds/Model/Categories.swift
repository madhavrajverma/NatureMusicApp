//
//  Category.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 02/09/22.
//

import Foundation


struct Category : Codable{
    let id:Int
    let Category:String
    let songs :[Song]
}

struct Song:Codable{
    let id:Int
    let name:String
    let url:String
}
