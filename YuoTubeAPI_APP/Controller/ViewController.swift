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
    
    private let playlistCollectionView = PlaylistCollectionView()
    private let secondPlaylistCollectionView = SecondPlaylistCollectionView()
    
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
        
        view.backgroundColor = .black
        
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        pageControl.numberOfPages = galleryCells.count
        
        //MARK: - playListLabel constraints
        view.addSubview(playListLabel)
        playListLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 40).isActive = true
        playListLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        playListLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
       
        //MARK: - PlaylistCollectionView constraints
        view.addSubview(playlistCollectionView)
        playlistCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playlistCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playlistCollectionView.topAnchor.constraint(equalTo: playListLabel.bottomAnchor, constant: 20).isActive = true
        playlistCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        playlistCollectionView.set(cells: VideoModel.fetchVideo())
        
        //MARK: - secondPlayListLabel constraints
        view.addSubview(secondPlayListLabel)
        secondPlayListLabel.topAnchor.constraint(equalTo: playlistCollectionView.bottomAnchor, constant: 40).isActive = true
        secondPlayListLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        secondPlayListLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
       
        //MARK: - PlaylistCollectionView constraints
        view.addSubview(secondPlaylistCollectionView)
        secondPlaylistCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        secondPlaylistCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        secondPlaylistCollectionView.topAnchor.constraint(equalTo: secondPlayListLabel.bottomAnchor, constant: 20).isActive = true
        secondPlaylistCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        secondPlaylistCollectionView.set(cells: VideoModel.fetchVideo())
        
        let timerOn = TimerOn(timer: timer)
        timerOn.execute(sender: self)

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


