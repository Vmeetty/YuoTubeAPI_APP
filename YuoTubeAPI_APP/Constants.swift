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
    
}
