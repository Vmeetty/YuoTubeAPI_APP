//
//  ChannelData.swift
//  YuoTubeAPI_APP
//
//  Created by user on 22.06.2022.
//

import Foundation

//MARK: - Channel Items
struct ChannelData: Codable {
    let items: [Item]
}

struct Item: Codable {
    let snippet: ChannelSnippet
    let contentDetails: ContentDetails
    let statistics: Statistics
}


//MARK: - Snippet with title and picture
struct ChannelSnippet: Codable {
    let title: String
    let thumbnails: Thumbnails
}


//MARK: - ContentDetails
struct ContentDetails: Codable {
    let relatedPlaylists: RelatedPlaylists
}

struct RelatedPlaylists: Codable {
    let uploads: String
}


//MARK: - Statistics
struct Statistics: Codable {
    let subscriberCount: String
}
