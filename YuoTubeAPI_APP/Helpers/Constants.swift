//
//  Constants.swift
//  YuoTubeAPI_APP
//
//  Created by user on 17.06.2022.
//

import Foundation
import UIKit

struct K {
    static let leftDistanceToView: CGFloat = 10
    static let rightDistanceToView: CGFloat = 10
    static let playlistMinimumLineSpacing: CGFloat = 10
    static let itemWidth: CGFloat = (UIScreen.main.bounds.width - leftDistanceToView - rightDistanceToView - (playlistMinimumLineSpacing / 2)) / 2
    static let galleryItemWidth: CGFloat = UIScreen.main.bounds.width - leftDistanceToView - rightDistanceToView
    
    struct Colors {
        static let firstColor = UIColor(red: 0.97, green: 0.24, blue: 0.58, alpha: 1.00)
        static let secondColor = UIColor(red: 0.46, green: 0.29, blue: 0.95, alpha: 1.00)
        static let backGroundColor = UIColor(red: 0.11, green: 0.10, blue: 0.09, alpha: 1.00)
    }
}
