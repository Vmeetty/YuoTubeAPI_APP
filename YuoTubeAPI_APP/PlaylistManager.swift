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
        NetworkManager.playlistRequestWith(playlistID) { videoItems in
            delegate?.retrievePlaylist(videos: videoItems)
        }
    }
    
}

