//
//  ViewController.swift
//  YuoTubeAPI_APP
//
//  Created by user on 16.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let pageControl = UIPageControl()

    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let galleryCollectionView = GalleryCollectionView()
    let playlistCollectionView = PlaylistCollectionView()
    let secondPlaylistCollectionView = SecondPlaylistCollectionView()
    var cardAnimationBrain = CardAnimationBrain()
    
    var networkManager = NetworkManager()
    
    var galleryCells = [ChannelModel]()
    
    var currentIndex = 0
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.textColor = .white
        label.text = "Youtube API"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let playListLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.text = "Playlist"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondPlayListLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.text = "Second Playlist"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let channelIDs = [
        K.Networking.CHANNEL_ID,
        K.Networking.SECOND_CHANNEL_ID,
        K.Networking.THIRD_CHANNEL_ID,
        K.Networking.FORTH_CHANNEL_ID
    ]
    
    var selectedVideoIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.delegate = self
        networkManager.fetchChannelListWith(channelIDs)
        networkManager.fetchPlaylistWith("OLAK5uy_mv965QiJkVkjx0ylLtaHAGCbIOC1ZQugI", for: playlistCollectionView)
        networkManager.fetchPlaylistWith("OLAK5uy_mc9GouYBjEMnOuI877I12lk0OOAlrh0CQ", for: secondPlaylistCollectionView)
        
        galleryCollectionView.galleryDelegate = self
        playlistCollectionView.playListDelegate = self
        secondPlaylistCollectionView.playListDelegate = self
        
        pageControl.numberOfPages = galleryCells.count
        
        contentView.backgroundColor = K.Colors.backGroundColor
        scrollView.backgroundColor = K.Colors.backGroundColor
        
        setupScrollView() // extension file
        setupUI() // extension file
        
//        cardAnimationBrain.configCardView(self)
        
    }

    @objc func moveToTheNextIndex() {
        if currentIndex < galleryCells.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        galleryCollectionView.isPagingEnabled = false
        galleryCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .right, animated: true)
        galleryCollectionView.isPagingEnabled = true
        pageControl.currentPage = currentIndex
    }
    
}

extension ViewController: NetworkManagerDelegate {
    
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func retrieveChannels(channels: [ChannelModel]) {
        DispatchQueue.main.async {
            self.galleryCollectionView.set(cells: channels)
            self.galleryCells = channels
            self.galleryCollectionView.reloadData()
            Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.moveToTheNextIndex), userInfo: nil, repeats: true)
        }
    }
    
    func retrievePlaylist(videos: [VideoModel], target: Any) {
        switch target {
        case is CardAnimationBrain:
            cardAnimationBrain.videos = videos
            cardAnimationBrain.configCardView(self)
            cardAnimationBrain.setVideoToCardVC(videos: videos, at: selectedVideoIndex)
        case is PlaylistCollectionView:
            playlistCollectionView.set(cells: videos)
            playlistCollectionView.reloadData()
        case is SecondPlaylistCollectionView:
            secondPlaylistCollectionView.set(cells: videos)
            secondPlaylistCollectionView.reloadData()
        default: break
        }
    }
    
}

extension ViewController: GalleryCollectionViewDelegate {
    func didGalleryItemSelected(_ channel: ChannelModel, at index: Int) {
        networkManager.fetchPlaylistWith(channel.uploads, for: cardAnimationBrain)
        selectedVideoIndex = index
    }
}

extension ViewController: PlaylistCollectionViewDelegate {
    func didPlaylistItemSelected(_ videos: [VideoModel], at index: Int) {
        cardAnimationBrain.videos = videos
        cardAnimationBrain.configCardView(self)
        cardAnimationBrain.setVideoToCardVC(videos: videos, at: index)
    }
}

extension ViewController: SecondPlaylistCollectionViewDelegate {
    func did2ndPlaylistItemSelected(_ videos: [VideoModel], at index: Int) {
        cardAnimationBrain.videos = videos
        cardAnimationBrain.configCardView(self)
        cardAnimationBrain.setVideoToCardVC(videos: videos, at: index)
    }
    
    
}

