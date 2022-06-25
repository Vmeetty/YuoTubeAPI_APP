//
//  SinglVideoData.swift
//  YuoTubeAPI_APP
//
//  Created by user on 26.06.2022.
//

import Foundation

struct SinglVideoData: Codable {
    let items: [VideoItems]
}

struct VideoItems: Codable {
    let statistics: VideoStatistics
}

struct VideoStatistics: Codable {
    let viewCount: String
}
