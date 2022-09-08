//
//  MusicDownloadManger.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 07/09/22.
//

import Foundation


enum NetworkError: Error {
    case  failure
    
    var message:String{
        switch self {
        case .failure:
           return  "Error occured in downloading data"
        }
    }
}

class MusicDownloadManger {
    
    
    static let instance = MusicDownloadManger()
    var dataTask:URLSessionDataTask?
    private init() { }
    
    let cacheManager  = CacheManager.instance
    
    func fetchSongAtUrl(_ item: String, completion : @escaping (Result<Data,NetworkError>) -> Void ) {
     dataTask?.cancel()
      guard let url = URL(string: item) else { return }
        
        let data = cacheManager.getMusic(songUrl: url)
    
        if let data = data {
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }else {
         dataTask  =   URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        completion(.success(data))
                    }
                    if error != nil {
                        completion(.failure(.failure))
                    }
                }
            }
        dataTask?.resume()
        }
    }
}
