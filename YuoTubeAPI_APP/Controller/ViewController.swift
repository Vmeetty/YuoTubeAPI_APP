//
//  ViewController.swift
//  YuoTubeAPI_APP
//
//  Created by user on 16.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private let playlistCollectionView = PlaylistCollectionView()
    private let secondPlaylistCollectionView = SecondPlaylistCollectionView()
    var cardAnimationBrain = CardAnimationBrain.shared
    
    var galleryCells = VideoModel.fetchVideo()
    
    var timer = GalleryTimer()
    var currentIndex = 0
    
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
        
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        pageControl.numberOfPages = galleryCells.count
        
        view.addSubview(playListLabel)
        view.addSubview(playlistCollectionView)
        view.addSubview(secondPlayListLabel)
        view.addSubview(secondPlaylistCollectionView)
        setupViewConstraints()
        
        playlistCollectionView.set(cells: VideoModel.fetchVideo())
        secondPlaylistCollectionView.set(cells: VideoModel.fetchVideo())
        
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
        galleryCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .right, animated: true)
        pageControl.currentPage = currentIndex
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
        cell.mainImageView.image = galleryCells[indexPath.row].image
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: galleryCollectionView.frame.width, height: galleryCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ViewController {
    private func setupViewConstraints() {
        //MARK: - playListLabel constraints
        playListLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 30).isActive = true
        playListLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        playListLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 10).isActive = true
       
        //MARK: - PlaylistCollectionView constraints
        playlistCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        playlistCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        playlistCollectionView.topAnchor.constraint(equalTo: playListLabel.bottomAnchor, constant: 20).isActive = true
        playlistCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        //MARK: - secondPlayListLabel constraints
        secondPlayListLabel.topAnchor.constraint(equalTo: playlistCollectionView.bottomAnchor, constant: 30).isActive = true
        secondPlayListLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        secondPlayListLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 10).isActive = true
       
        //MARK: - PlaylistCollectionView constraints
        secondPlaylistCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        secondPlaylistCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        secondPlaylistCollectionView.topAnchor.constraint(equalTo: secondPlayListLabel.bottomAnchor, constant: 20).isActive = true
        secondPlaylistCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
}

