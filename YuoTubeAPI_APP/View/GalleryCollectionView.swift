//
//  GalleryCollectionView.swift
//  YuoTubeAPI_APP
//
//  Created by user on 16.06.2022.
//

import Foundation
import UIKit

class GalleryCollectionView: UICollectionView {
    
    var cells = [VideoModel]()
    
    var timer: Timer?
    var currentCellIndex = 0
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = .black
        delegate = self
        dataSource = self
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseID)
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = K.playlistMinimumLineSpacing
        contentInset = UIEdgeInsets(top: 0, left: K.leftDistanceToView, bottom: 0, right: K.rightDistanceToView)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        isPagingEnabled = true
        
        startTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(cells: [VideoModel]) {
        self.cells = cells
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToTheNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc func moveToTheNextIndex() {
        if currentCellIndex < cells.count - 1 {
            currentCellIndex += 1
        } else {
            currentCellIndex = 0
        }
        scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
    }

}


extension GalleryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseID, for: indexPath) as! GalleryCollectionViewCell
        cell.mainImageView.image = cells[indexPath.row].image
        
        return cell
    }
}

extension GalleryCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: K.galleryItemWidth, height: frame.height)
    }
}
