//
//  Util.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 02/09/22.
//

import Foundation


func getImageName(Category :String) -> String {
    if(Category == "Meditation") {
        return "meditation"
    }else if (Category == "Rain") {
        return "rain-1"
    }else if(Category=="Sea") {
        return "sea"
    }else if(Category == "Forest") {
        return "forest"
    }else if(Category == "Sleep") {
        return "sleep"
    }else if(Category == "Insects") {
        return "insects"
    }else if(Category == "Relaxation") {
        return "relax"
    }else if(Category == "Study") {
        return "study"
    }else if(Category == "Trains") {
        return "train"
    }else {
        return "empty"
    }
}
