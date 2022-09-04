//
//  CacheManager.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 05/09/22.
//

import Foundation

class CacheManager {
    static let instance = CacheManager()
    
    private init() { }
    
    var audioCache: NSCache<NSString,NSData> = {
        let cache = NSCache<NSString,NSData>()
        cache.countLimit = 10
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    func addMusic(songUrl:URL,data:Data) {
        let songString = songUrl.absoluteString
        let nsString = NSString(string: songString)
        let nsData = NSData(data: data)

        audioCache.setObject(nsData, forKey: nsString)
        print("Added to cache")
        
    }
    
    func remove(songUrl:URL) {
        let songString = songUrl.absoluteString
        let nsString = NSString(string: songString)
        
        audioCache.removeObject(forKey: nsString)
    }
    
    
    func getMusic(songUrl:URL) -> Data? {
        let songString = songUrl.absoluteString
        let nsString = NSString(string: songString)
        
        let nsData = audioCache.object(forKey: nsString)
        guard let nsData = nsData else {
            return nil
        }

        let data = Data(referencing: nsData)
        return data
    }
    
    
}
