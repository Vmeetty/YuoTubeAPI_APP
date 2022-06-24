//
//  PlaylistData.swift
//  YuoTubeAPI_APP
//
//  Created by user on 22.06.2022.
//

import Foundation

//MARK: - Snippet
struct PlaylistData: Codable {
    let items: [VideoData]
}

struct VideoData: Codable {
    let snippet: VideoSnippet
}

struct VideoSnippet: Codable {
    let title: String
    let thumbnails: Thumbnails
    let resourceId: ResourceId
}


//MARK: - Video ID
struct ResourceId: Codable {
    let videoId: String
}

