//
//  PlaylistData.swift
//  YuoTubeAPI_APP
//
//  Created by user on 22.06.2022.
//

import Foundation

//MARK: - Snippet
struct PlaylistData: Codable {
    let items: [PlaylistItems]
}

struct PlaylistItems: Codable {
    let snippet: PlaylistSnippet
}

struct PlaylistSnippet: Codable {
    let title: String
    let thumbnails: Thumbnails
    let resourceId: ResourceId
}


//MARK: - Thumbnails
struct Thumbnails: Codable {
    let medium: Medium
}

struct Medium: Codable {
    let url: String
}


//MARK: - Video ID
struct ResourceId: Codable {
    let videoId: String
}

