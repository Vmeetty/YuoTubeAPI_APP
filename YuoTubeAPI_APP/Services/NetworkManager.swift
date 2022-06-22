//
//  NetworkManager.swift
//  YuoTubeAPI_APP
//
//  Created by user on 22.06.2022.
//

import Foundation
import UIKit

protocol NetworkManagerDelegate: AnyObject {
    func didFailWithError(error: Error)
    func gotChannels(channels: [ChannelModel])
}

struct NetworkManager {
    
    weak var delegate: NetworkManagerDelegate?
    
    //MARK: - URL preparing
    func fetchChannelListWith(channel ids: [String], andAPIKey key: String) {
        var url = "\(K.Networking.BASIC_CHANNEL_URL)part=snippet%2CcontentDetails%2Cstatistics&key=\(K.Networking.API_KEY)&id="

        for (index, item) in ids.enumerated() {
            url += item
            if index < ids.count - 1 {
                url += "%2C%20"
            }
        }
        performChannelRequest(with: url)
    }
    
    
    private func performChannelRequest(with urlStr: String) {
        if let url = URL(string: urlStr) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                }
                guard let safeData = data else {
                    fatalError("Fail to get channel data")
                }
                if let channels = parseChannelJSON(safeData) {
                    self.delegate?.gotChannels(channels: channels)
                }
            }
            task.resume()
        }
    }
    
    private func parseChannelJSON(_ data: Data) -> [ChannelModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ChannelData.self, from: data)
            var items = [ChannelModel]()
            for item in decodedData.items {
                let title = item.snippet.title
                let subscribers = item.statistics.subscriberCount
                let imageUrlStr = item.snippet.thumbnails.medium.url
//                let thumbnail = retrieveThumbnailWith(url: imageUrlStr)
                let channel = ChannelModel(title: title, subscribers: subscribers, thumbnail: imageUrlStr)
                items.append(channel)
            }
            return items
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
