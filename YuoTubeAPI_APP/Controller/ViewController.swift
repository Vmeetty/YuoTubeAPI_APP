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
    
    var galleryCells = VideoModel.fetchVideo()
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.delegate = self
        networkManager.fetchChannelListWith(channel: channelIDs, andAPIKey: K.Networking.API_KEY)
        
        galleryCollectionView.galleryDelegate = self
        
        pageControl.numberOfPages = galleryCells.count
        
        contentView.backgroundColor = K.Colors.backGroundColor
        scrollView.backgroundColor = K.Colors.backGroundColor
        
        setupScrollView()
        setupUI()
        
        let videos = VideoModel.fetchVideo()
        playlistCollectionView.set(cells: videos)
        secondPlaylistCollectionView.set(cells: videos)
        
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
    func gotChannels(channels: [ChannelModel]) {
        DispatchQueue.main.async {
            self.galleryCollectionView.set(cells: channels)
            self.galleryCollectionView.reloadData()
            Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.moveToTheNextIndex), userInfo: nil, repeats: true)
        }
    }
}

extension ViewController: GalleryCollectionViewDelegate {
    func didGalleryItemSelected(_ channel: ChannelModel) {
        cardAnimationBrain.channel = channel
        cardAnimationBrain.configCardView(self)
        cardAnimationBrain.handleTap()
    }
}

