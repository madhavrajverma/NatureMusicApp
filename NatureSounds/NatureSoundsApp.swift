//
//  NatureSoundsApp.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 31/08/22.
//

import SwiftUI

@main
struct NatureSoundsApp: App {
    @StateObject var homeVM = HomeViewModel()
    @StateObject var audioVM = AudioPlayerViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homeVM)
                .environmentObject(audioVM)
        }
    }
}
