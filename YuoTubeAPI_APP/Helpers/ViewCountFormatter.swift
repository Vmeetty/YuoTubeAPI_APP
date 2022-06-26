//
//  ViewCountFormatter.swift
//  YuoTubeAPI_APP
//
//  Created by user on 26.06.2022.
//

import Foundation


struct ViewCountFormatter {
    
    static let shared = ViewCountFormatter()
    
    func formatViewCount(viewCount: String) -> String {
        guard let int = Int(viewCount) else { return viewCount }
        let formatedInt = int.formattedWithSeparator
        return String(formatedInt)
    }
    
}
