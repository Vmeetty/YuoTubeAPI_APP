//
//  CacheManager.swift
//  YuoTubeAPI_APP
//
//  Created by user on 23.06.2022.
//

import Foundation

class CacheManager {
    
    static var cache = [String : Data]()
    
    static func setImageCache(_ url: String, _ data: Data) {
        cache[url] = data
    }
    
    static func getImageCache(_ url: String) -> Data? {
        return cache[url]
    }
}
