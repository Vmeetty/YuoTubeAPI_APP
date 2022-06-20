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
    var cardAnimationBrain = CardAnimationBrain.shared
    
    var galleryCells = VideoModel.fetchVideo()
    
    var timer = GalleryTimer()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages = galleryCells.count
        
        contentView.backgroundColor = K.Colors.backGroundColor
        scrollView.backgroundColor = K.Colors.backGroundColor
        
        setupScrollView()
        setupUI()
        
        let videos = VideoModel.fetchVideo()
        galleryCollectionView.set(cells: videos)
        playlistCollectionView.set(cells: videos)
        secondPlaylistCollectionView.set(cells: videos)
        
        let timerOn = TimerOn(timer: timer)
        timerOn.execute(sender: self)
        
        cardAnimationBrain.setupFakeHandleView(self)
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





