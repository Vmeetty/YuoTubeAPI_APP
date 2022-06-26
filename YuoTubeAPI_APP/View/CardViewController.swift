//
//  CardViewController.swift
//  YuoTubeAPI_APP
//
//  Created by user on 18.06.2022.
//

import UIKit
import AVFoundation

class CardViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previosButton: UIButton!
    @IBOutlet weak var handleIcon: UIImageView!
    
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    var videoData: [VideoModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        
        let url = URL(string: "https://argon.stream.voidboost.in/movies/e96d1884c52c6c5744af956b7a8110fdf1ccd93d/a4f5462f261e43c8963cb2356497982f:2022062505:f20d99fc-1483-4785-b7e6-f7e2011773e0/240.mp4:hls:manifest.m3u8")!
        player = AVPlayer(url: url)
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resize
        
        videoView.layer.addSublayer(playerLayer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player.play()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = videoView.bounds
    }
    
    func configUI() {
        playButton.setTitle("", for: .normal)
        nextButton.setTitle("", for: .normal)
        previosButton.setTitle("", for: .normal)
    }
    
    func updateUI(videos: [VideoModel], at index: Int) {
        videoData = videos
        guard let videoData = videoData else { return }
        
        let videoItem = videoData[index]
        videoTitleLabel.text = videoItem.title
        viewCountLabel.text = ViewCountFormatter.shared.formatViewCount(viewCount: videoItem.viewCont) + " просмотров"
        
    }

}
