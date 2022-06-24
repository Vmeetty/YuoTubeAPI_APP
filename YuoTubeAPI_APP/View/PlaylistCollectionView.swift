//
//  PlaylistCollectionView.swift
//  YuoTubeAPI_APP
//
//  Created by user on 17.06.2022.
//

import UIKit

class PlaylistCollectionView: UICollectionView {

    var cells = [VideoModel]()
    
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: PlaylistCollectionViewCell.reuseID, for: indexPath) as! PlaylistCollectionViewCell
        cell.mainImageView.image = UIImage(named: "buzz") // cells[indexPath.row].image
        cell.titleLabel.text = "Buzz" // cells[indexPath.row].title
        cell.viewsLabel.text = "4000 views" // cells[indexPath.row].views
        
        return cell
    }
}

extension PlaylistCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: K.itemWidth, height: frame.height)
    }
}
