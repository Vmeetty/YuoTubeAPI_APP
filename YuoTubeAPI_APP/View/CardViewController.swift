//
//  CardViewController.swift
//  YuoTubeAPI_APP
//
//  Created by user on 18.06.2022.
//

import UIKit
import AVFoundation
import youtube_ios_player_helper

class CardViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previosButton: UIButton!
    @IBOutlet weak var handleIcon: UIImageView!
    
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var videoView: YTPlayerView!
    
    
    var videoData: [VideoModel]?
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func updateUI(videos: [VideoModel], at index: Int) {
        videoData = videos
        setCurrentVideoWith(index: index)
    }
    
    private func configUI() {
        playButton.setTitle("", for: .normal)
        nextButton.setTitle("", for: .normal)
        previosButton.setTitle("", for: .normal)
    }
    
    private func setCurrentVideoWith(index: Int) {
        guard let videoData = videoData else { return }
        let videoItem = videoData[index]
        selectedIndex = index
        videoView.load(withVideoId: videoItem.videoID, playerVars: ["controls": 0, "showinfo": 0])
        videoTitleLabel.text = videoItem.title
        viewCountLabel.text = ViewCountFormatter.shared.formatViewCount(viewCount: videoItem.viewCont) + " просмотров"
        playButton.isSelected = false
    }
    
    
    @IBAction func playPauseAction(_ sender: UIButton) {
        if playButton.isSelected {
            videoView.pauseVideo()
            playButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            videoView.playVideo()
            playButton.setImage(UIImage(named: "pause"), for: .selected)
        }
        playButton.isSelected = !playButton.isSelected
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        selectedIndex += 1
        setCurrentVideoWith(index: selectedIndex)
    }
    
    @IBAction func previosAction(_ sender: UIButton) {
        selectedIndex -= 1
        setCurrentVideoWith(index: selectedIndex)
    }
    
}
