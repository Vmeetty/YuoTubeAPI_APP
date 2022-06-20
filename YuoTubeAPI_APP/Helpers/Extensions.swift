//
//  Extensions.swift
//  YuoTubeAPI_APP
//
//  Created by user on 20.06.2022.
//

import Foundation


extension ViewController {
    func setupViewConstraints() {
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
