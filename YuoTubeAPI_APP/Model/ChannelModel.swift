//
//  ChannelModel.swift
//  YuoTubeAPI_APP
//
//  Created by user on 22.06.2022.
//

import Foundation
import UIKit

struct ChannelModel {
    let title: String
    let subscribers: String
    let thumbnail: String
    let uploads: String
}

extension ChannelModel: Displayable {
    var titleLabelText: String {
        title
    }
}
