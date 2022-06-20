//
//  GalleryTimer.swift
//  YuoTubeAPI_APP
//
//  Created by user on 17.06.2022.
//

import Foundation
import UIKit


protocol CanBeOn {
    func on(sender: ViewController)
}
protocol CanBeOff {
    func off(sender: ViewController)
}


class GalleryTimer: CanBeOn, CanBeOff {

    private var timer: Timer?

    func on(sender: ViewController) {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: sender, selector: #selector(sender.moveToTheNextIndex), userInfo: nil, repeats: true)
    }

    func off(sender: ViewController) {

    }

}

class TimerOn {
    private let timer: CanBeOn

    init(timer: CanBeOn) {
        self.timer = timer
    }

    func execute(sender: ViewController) {
        timer.on(sender: sender)
    }
}

class TimerOff {
    let timer: CanBeOff

    init(timer: CanBeOff) {
        self.timer = timer
    }

    func execute(sender: ViewController) {
        timer.off(sender: sender)
    }
}

//class GalleryTimer {
//
//    static let shared = GalleryTimer()
//
//    private var timer: Timer?
//
//    func startTimer(sender: ViewController) {
//        timer = Timer.scheduledTimer(timeInterval: 2.0, target: sender, selector: #selector(sender.moveToTheNextIndex), userInfo: nil, repeats: true)
//    }
//}
