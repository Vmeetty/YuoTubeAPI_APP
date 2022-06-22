//
//  Extensions.swift
//  YuoTubeAPI_APP
//
//  Created by user on 20.06.2022.
//

import Foundation
import UIKit


extension ViewController {
    
    func setupUI() {
        
        //MARK: - Title label
        contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 45).isActive = true
        
        //MARK: - GalleryCollectionView constraints
        contentView.addSubview(galleryCollectionView)
        galleryCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        galleryCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        galleryCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        galleryCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        //MARK: - pageCotroll constraints
        contentView.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: galleryCollectionView.bottomAnchor, constant: 20),
            pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        //MARK: - playListLabel constraints
        contentView.addSubview(playListLabel)
        playListLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 50).isActive = true
        playListLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        playListLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10).isActive = true
       
        //MARK: - PlaylistCollectionView constraints
        contentView.addSubview(playlistCollectionView)
        playlistCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        playlistCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        playlistCollectionView.topAnchor.constraint(equalTo: playListLabel.bottomAnchor, constant: 20).isActive = true
        playlistCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        //MARK: - secondPlayListLabel constraints
        contentView.addSubview(secondPlayListLabel)
        secondPlayListLabel.topAnchor.constraint(equalTo: playlistCollectionView.bottomAnchor, constant: 0).isActive = true
        secondPlayListLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        secondPlayListLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10).isActive = true
       
        //MARK: - PlaylistCollectionView constraints
        contentView.addSubview(secondPlaylistCollectionView)
        secondPlaylistCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        secondPlaylistCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        secondPlaylistCollectionView.topAnchor.constraint(equalTo: secondPlayListLabel.bottomAnchor, constant: 20).isActive = true
        secondPlaylistCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        secondPlaylistCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40).isActive = true
        
    }
    
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
}

