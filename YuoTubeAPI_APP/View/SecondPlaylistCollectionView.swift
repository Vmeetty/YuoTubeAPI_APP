//
//  SecondPlaylistCollectionView.swift
//  YuoTubeAPI_APP
//
//  Created by user on 17.06.2022.
//

import UIKit

class SecondPlaylistCollectionView: UICollectionView {

    var cells = [VideoModel]()
    var playlistManager = PlaylistManager()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = K.Colors.backGroundColor
        delegate = self
        dataSource = self
        playlistManager.delegate = self
        playlistManager.fetchPlaylistWith("OLAK5uy_mv965QiJkVkjx0ylLtaHAGCbIOC1ZQugI")
        
        register(SecondPlaylistCollectionViewCell.self, forCellWithReuseIdentifier: SecondPlaylistCollectionViewCell.reuseID)
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = K.playlistMinimumLineSpacing
        contentInset = UIEdgeInsets(top: 0, left: K.leftDistanceToView, bottom: 0, right: K.rightDistanceToView)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(cells: [VideoModel]) {
        self.cells = cells
    }
}

extension SecondPlaylistCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: SecondPlaylistCollectionViewCell.reuseID, for: indexPath) as! SecondPlaylistCollectionViewCell
       
        cell.setCell(video: cells[indexPath.row])
        
        return cell
    }
}

extension SecondPlaylistCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: K.itemWidth, height: frame.height)
    }
}


extension SecondPlaylistCollectionView: PlaylistManagerDelegate {
    func didFailWithError(error: Error) {
        print("Fail fetching playlist with: \(error)")
    }
    
    func retrievePlaylist(videos: [VideoModel]) {
        DispatchQueue.main.async {
            self.cells = videos
            self.reloadData()
        }
    }
    
    
}


