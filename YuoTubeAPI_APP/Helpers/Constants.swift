//
//  Constants.swift
//  YuoTubeAPI_APP
//
//  Created by user on 17.06.2022.
//

import Foundation
import UIKit

struct K {
    static let leftDistanceToView: CGFloat         = 10
    static let rightDistanceToView: CGFloat        = 10
    static let playlistMinimumLineSpacing: CGFloat = 10
    static let itemWidth: CGFloat                  = (UIScreen.main.bounds.width - leftDistanceToView - rightDistanceToView - (playlistMinimumLineSpacing / 2)) / 2
    static let galleryItemWidth: CGFloat           = UIScreen.main.bounds.width - leftDistanceToView - rightDistanceToView
    
    struct Colors {
        static let firstColor      = UIColor(red: 0.97, green: 0.24, blue: 0.58, alpha: 1.00)
        static let secondColor     = UIColor(red: 0.46, green: 0.29, blue: 0.95, alpha: 1.00)
        static let backGroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.15, alpha: 1.00)
    }
    
    struct Networking {
        static let API_KEY            = "AIzaSyBiidy3RXBRoakJ3nmEhAArvgEOYCwVLoE"
        // channelID matches with uploads
        static let CHANNEL_ID         = "UCWOA1ZGywLbqmigxE4Qlvuw" // Netflix
        static let SECOND_CHANNEL_ID  = "UCVTQuK2CaWaTgSsoNkn5AiQ" // HBO
        static let THIRD_CHANNEL_ID   = "UCvC4D8onUfXzvjTOM-dBfEA" // Marvel
        static let FORTH_CHANNEL_ID   = "UC2-BeLxzUBSs0uSrmzWhJuQ" // 20 century fox
        
        static let PLAYLIST_ID        = ""
        static let SECOND_PLAYLIST_ID = ""
        
        static let BASIC_PLAYLIST_URL = "https://youtube.googleapis.com/youtube/v3/playlistItems?"
        static let BASIC_VIDEO_URL    = "https://youtube.googleapis.com/youtube/v3/videos?"
        static let BASIC_CHANNEL_URL  = "https://youtube.googleapis.com/youtube/v3/channels?"
    }
}
