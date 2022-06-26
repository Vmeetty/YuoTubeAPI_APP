//
//  NetworkManager.swift
//  YuoTubeAPI_APP
//
//  Created by user on 22.06.2022.
//

import Foundation
import UIKit
import Alamofire

protocol NetworkManagerDelegate: AnyObject {
    func didFailWithError(error: Error)
    func retrieveChannels(channels: [ChannelModel])
    func retrievePlaylist(videos: [VideoModel], target: Any)
}

struct NetworkManager {
    
    weak var delegate: NetworkManagerDelegate?
    
    //MARK: - URL preparing
    func fetchChannelListWith(_ ids: [String]) {
        let url = K.Networking.BASIC_CHANNEL_URL
        var parameters: [String: String] = ["part": "snippet, contentDetails, statistics", "key": K.Networking.API_KEY, "id": ""]
        for (index, item) in ids.enumerated() {
            parameters["id"]! += item
            if index < ids.count - 1 {
                parameters["id"]! += ","
            }
        }
        channelRequestWith(url, and: parameters)
    }
    
    //MARK: - Perform Request for the Channels
    private func channelRequestWith(_ urlStr: String, and parameters: [String: String]) {
        AF.request(urlStr, parameters: parameters)
            .validate()
            .responseDecodable(of: ChannelData.self) { response in
                guard let channels = response.value else { return }
                var items = [ChannelModel]()
                for item in channels.items {
                    let title = item.snippet.title
                    let subscribers = item.statistics.subscriberCount
                    let thumbnail = item.snippet.thumbnails.medium.url
                    let uploads = item.contentDetails.relatedPlaylists.uploads
                    
                    let channel = ChannelModel(
                        title: title,
                        subscribers: subscribers,
                        thumbnail: thumbnail,
                        uploads: uploads
                    )
                    items.append(channel)
                }
                delegate?.retrieveChannels(channels: items)
            }
    }
    
    //MARK: - Perform Request for uploads of the current channel
    func fetchPlaylistWith(_ playlistID: String, for target: Any) {
        let url = K.Networking.BASIC_PLAYLIST_URL
        let parameters: [String: String] = ["part": "snippet", "maxResults": "10", "playlistId": playlistID, "key": K.Networking.API_KEY]
        playlistRequestWith(url, and: parameters, target: target)
    }
    
    
    private func playlistRequestWith(_ url: String, and parameters: [String: String], target: Any) {
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
                
                delegate?.retrievePlaylist(videos: videoItems, target: target)
            }
    }
    
    static func fetchVideoStatisticsWith(id: String, complition: @escaping (String) -> Void) {
        let url = K.Networking.BASIC_VIDEO_URL
        let parameters = ["part": "statistics", "id": id, "key": K.Networking.API_KEY]
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: SinglVideoData.self) { response in
                guard let videos = response.value else { return }
                let viewCount = videos.items[0].statistics.viewCount
                complition(viewCount)
            }
    }
    
    
    static func retrieveThumbnailWith(url: String, complition: @escaping (UIImage, URL) -> Void){
        if let url = URL(string: url) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { data, _, error in
                if error == nil, data != nil {
                    
                    // Save the data in the cache
                    CacheManager.setImageCache(url.absoluteString, data!)
                    
                    guard let image = UIImage(data: data!) else {
                        fatalError("Fail to retieve image")
                    }
                    complition(image, url)
                }
            }
            task.resume()
        }
    }
    
}
