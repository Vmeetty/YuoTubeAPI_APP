//
//  PlaylistCollectionViewCell.swift
//  YuoTubeAPI_APP
//
//  Created by user on 17.06.2022.
//

import UIKit

class PlaylistCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "PlaylistCollectionViewCell"
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var item: VideoModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mainImageView)
        addSubview(titleLabel)
        addSubview(viewsLabel)
        
        backgroundColor = K.Colors.backGroundColor
        
        //MARK: - mainImageView constraints
        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        
        //MARK: - titleLabel constraints
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 20).isActive = true
        
        //MARK: - viewsLabel constraints
        viewsLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        viewsLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        viewsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        
    }
    
    func setCell(video: VideoModel) {
        item = video
        if let item = item {
            NetworkManager.fetchVideoStatisticsWith(id: item.videoID) { viewCount in
                self.viewsLabel.text = ViewCountFormatter.shared.formatViewCount(viewCount: viewCount) + " просмотров"
            }
            titleLabel.text = item.title
            guard item.imageURL != "" else { return }
            if let cachedData = CacheManager.getImageCache(item.imageURL) {
                mainImageView.image = UIImage(data: cachedData)
                return
            }
            NetworkManager.retrieveThumbnailWith(url: item.imageURL) { [weak self] image, url in
                if url.absoluteString != self?.item?.imageURL {
                    return
                }
                DispatchQueue.main.async {
                    self?.mainImageView.image = image
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
