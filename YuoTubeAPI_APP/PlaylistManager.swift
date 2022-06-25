//
//  PlaylistManager.swift
//  YuoTubeAPI_APP
//
//  Created by user on 25.06.2022.
//

import Foundation
import Alamofire

protocol PlaylistManagerDelegate: AnyObject {
    func didFailWithError(error: Error)
    func retrievePlaylist(videos: [VideoModel])
}

struct PlaylistManager {
    
    weak var delegate: PlaylistManagerDelegate?
    
    //MARK: - Perform Request for uploads of the current channel
    func fetchPlaylistWith(_ playlistID: String) {
        let url = K.Networking.BASIC_PLAYLIST_URL
        let parameters: [String: String] = ["part": "snippet", "maxResults": "10", "playlistId": playlistID, "key": K.Networking.API_KEY]
        playlistRequestWith(url, and: parameters)
    }
    
    
    private func playlistRequestWith(_ url: String, and parameters: [String: String]) {
        var videoItems = [VideoModel]()
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: PlaylistData.self) { response in
                guard let videos = response.value else { return }
                for item in videos.items {
                    let title = item.snippet.title
                    let imageURL = item.snippet.thumbnails.medium.url
                    let videoID = item.snippet.resourceId.videoId
                    
                    let newVideo = VideoModel(title: title, imageURL: imageURL, videoID: videoID)
                    videoItems.append(newVideo)
                }
                delegate?.retrievePlaylist(videos: videoItems)
            }
    }
}

