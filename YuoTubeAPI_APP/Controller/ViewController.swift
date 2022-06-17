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
    
    var galleryCells = VideoModel.fetchVideo()
    
    var timer: Timer?
    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        pageControl.numberOfPages = galleryCells.count
        view.addSubview(playlistCollectionView)
       
        //MARK: - PlaylistCollectionView constraints
        playlistCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playlistCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playlistCollectionView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 40).isActive = true
        playlistCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        playlistCollectionView.set(cells: VideoModel.fetchVideo())
        startTimer()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(moveToTheNextIndex), userInfo: nil, repeats: true)
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


