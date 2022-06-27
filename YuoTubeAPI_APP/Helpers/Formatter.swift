//
//  ViewCountFormatter.swift
//  YuoTubeAPI_APP
//
//  Created by user on 26.06.2022.
//

import Foundation


struct Formatter {
    
    static let shared = Formatter()
    
    func formatViewCount(viewCount: String) -> String {
        guard let int = Int(viewCount) else { return viewCount }
        let formatedInt = int.formattedWithSeparator
        return String(formatedInt)
    }
    
    func formatVideo(duration: String) -> String {
        var duration = duration
        if duration.hasPrefix("PT") { duration.removeFirst(2) }
        let hour, minute, second: Double
        if let index = duration.firstIndex(of: "H") {
            hour = Double(duration[..<index]) ?? 0
            duration.removeSubrange(...index)
        } else { hour = 0 }
        if let index = duration.firstIndex(of: "M") {
            minute = Double(duration[..<index]) ?? 0
            duration.removeSubrange(...index)
        } else { minute = 0 }
        if let index = duration.firstIndex(of: "S") {
            second = Double(duration[..<index]) ?? 0
        } else { second = 0 }
        return Formatter.positional.string(from: hour * 3600 + minute * 60 + second) ?? "0:00"
    }
    
}
