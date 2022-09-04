//
//  MusicDownload.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 05/09/22.
//

import Foundation


class MusicDownlaod: ObservableObject {
    
    @Published var data = Data()
    @Published var songUrl:URL?
    @Published var isDownloadComplete: Bool = false

    let cacheManager = CacheManager.instance
    
    func fetchSongAtUrl(_ item: String) {
      guard let url = URL(string: item) else { return }
        self.songUrl = url
        
        guard let songUrl = songUrl else {
            return
        }
        
        let data = cacheManager.getMusic(songUrl: songUrl)
    
        if let data = data {
            DispatchQueue.main.async {
                self.data = data
                self.isDownloadComplete = true
            }
        }else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.data = data
                        if let songUrl = self.songUrl {
                            self.cacheManager.addMusic(songUrl: songUrl, data: data)
                            self.isDownloadComplete = true
                        }
                    }
                   
                }
            }.resume()
            
        }
    }
    
}
