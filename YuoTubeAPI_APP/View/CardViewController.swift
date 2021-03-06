//
//  CardViewController.swift
//  YuoTubeAPI_APP
//
//  Created by user on 18.06.2022.
//

import UIKit
import youtube_ios_player_helper


class CardViewController: UIViewController, YTPlayerViewDelegate {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previosButton: UIButton!
    @IBOutlet weak var handleIcon: UIImageView!
    
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var videoView: YTPlayerView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    
    var videoData: [VideoModel]?
    
    let format = Formatter.shared
    
    var selectedIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        videoView.delegate = self
        configUI()
    }
    
    func playerView(_ playerView: YTPlayerView, didPlayTime playTime: Float) {
        currentTimeLabel.text = format.secondsToTimestamp(interval: playTime)
        progressSlider.value = playTime
    }
    
    func updateUI(videos: [VideoModel], at index: Int) {
        videoData = videos
        setCurrentVideoWith(index: index)
    }
    
    private func configUI() {
        playButton.setTitle("", for: .normal)
        nextButton.setTitle("", for: .normal)
        previosButton.setTitle("", for: .normal)
        progressSlider.setThumbImage(UIImage(named: "or"), for: .normal)
    }
    
    private func setCurrentVideoWith(index: Int) {
        guard let videoData = videoData else { return }
        let videoItem = videoData[index]
        selectedIndex = index
        videoView.load(withVideoId: videoItem.videoID, playerVars: ["controls": 0, "showinfo": 0])
        videoTitleLabel.text = videoItem.title
        viewCountLabel.text = format.formatViewCount(viewCount: videoItem.viewCont) + " просмотров"
        durationLabel.text = format.formatVideo(duration: videoItem.duration)
        progressSlider.minimumValue = 0
        progressSlider.maximumValue = format.formatIntoSeconds(duration: videoItem.duration)
        currentTimeLabel.text = format.secondsToTimestamp(interval: 0)
        progressSlider.value = 0

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
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        videoView.seek(toSeconds: sender.value, allowSeekAhead: true)
    }
    
    @IBAction func volumeChanged(_ sender: UISlider) {
        
    }
}


