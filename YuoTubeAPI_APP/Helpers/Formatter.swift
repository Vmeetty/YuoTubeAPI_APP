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
    
    func formatIntoSeconds(duration: String) -> Float {
        var duration = duration
        if duration.hasPrefix("PT") { duration.removeFirst(2) }
        let hour, minute, second: Int
        if let index = duration.firstIndex(of: "H") {
            hour = Int(duration[..<index]) ?? 0
            duration.removeSubrange(...index)
        } else { hour = 0 }
        if let index = duration.firstIndex(of: "M") {
            minute = Int(duration[..<index]) ?? 0
            duration.removeSubrange(...index)
        } else { minute = 0 }
        if let index = duration.firstIndex(of: "S") {
            second = Int(duration[..<index]) ?? 0
        } else { second = 0 }
        
        let seconds = ((hour * 60) * 60) + (minute * 60) + second
        return Float(seconds)
    }
    
    func formatSecondsToTime(interval: Float) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional

        return formatter.string(from: TimeInterval(interval))!
    }
    
    func secondsToTimestamp(interval: Float) -> String {
        let hour = Int(interval) / 3600
        let minute = Int(interval) / 60 % 60
        let second = Int(interval) % 60
        
        if hour != 0 {
            return String(format: "%02i:%02i:%02i", hour, minute, second)
        }
        // return formated string
        return String(format: "%02i:%02i", minute, second)
    }
}
