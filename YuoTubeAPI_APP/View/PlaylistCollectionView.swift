//
//  PlaylistCollectionView.swift
//  YuoTubeAPI_APP
//
//  Created by user on 17.06.2022.
//

import UIKit

protocol PlaylistCollectionViewDelegate: AnyObject {
    func didPlaylistItemSelected(_ videos: [VideoModel], at index: Int)
}

class PlaylistCollectionView: UICollectionView {

    var cells = [VideoModel]()
    
    weak var playListDelegate: PlaylistCollectionViewDelegate?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = K.Colors.backGroundColor
        delegate = self
        dataSource = self
        register(PlaylistCollectionViewCell.self, forCellWithReuseIdentifier: PlaylistCollectionViewCell.reuseID)
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

extension PlaylistCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: PlaylistCollectionViewCell.reuseID, for: indexPath) as! PlaylistCollectionViewCell
        
        cell.setCell(video: cells[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        playListDelegate?.didPlaylistItemSelected(cells, at: indexPath.row)
    }
}

extension PlaylistCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: K.itemWidth, height: frame.height)
    }
}
