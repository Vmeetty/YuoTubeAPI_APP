//
//  SecondPlaylistCollectionView.swift
//  YuoTubeAPI_APP
//
//  Created by user on 17.06.2022.
//

import UIKit

protocol SecondPlaylistCollectionViewDelegate: AnyObject {
    func did2ndPlaylistItemSelected(_ videos: [VideoModel], at index: Int)
}

class SecondPlaylistCollectionView: UICollectionView {

    weak var playListDelegate: SecondPlaylistCollectionViewDelegate?
    
    var cells = [VideoModel]()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = K.Colors.backGroundColor
        delegate = self
        dataSource = self
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        playListDelegate?.did2ndPlaylistItemSelected(cells, at: indexPath.row)
    }
}

extension SecondPlaylistCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: K.itemWidth, height: frame.height)
    }
}




