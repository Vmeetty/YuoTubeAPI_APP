//
//  ViewController.swift
//  YuoTubeAPI_APP
//
//  Created by user on 16.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private let galleryCollectionView = GalleryCollectionView()
    private let playlistCollectionView = PlaylistCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(galleryCollectionView)
        view.addSubview(playlistCollectionView)
        
        //MARK: - GalleryCollectionView constraints
        galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        galleryCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        galleryCollectionView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        galleryCollectionView.set(cells: VideoModel.fetchVideo())
        
        //MARK: - PlaylistCollectionView constraints
        playlistCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playlistCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playlistCollectionView.topAnchor.constraint(equalTo: galleryCollectionView.bottomAnchor, constant: 100).isActive = true
        playlistCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        playlistCollectionView.set(cells: VideoModel.fetchVideo())
        
        galleryCollectionView.startTimer()
    }

    
    

}

