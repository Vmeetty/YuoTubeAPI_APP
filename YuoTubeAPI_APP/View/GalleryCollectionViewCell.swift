//
//  GalleryCollectionViewCell.swift
//  YuoTubeAPI_APP
//
//  Created by user on 17.06.2022.
//

import UIKit
import Alamofire

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "GalleryCollectionViewCell"

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
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var channelItem: ChannelModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mainImageView)
        addSubview(titleLabel)
        addSubview(viewsLabel)
        
        //MARK: - mainImageView constraints
        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        //MARK: - titleLabel constraints
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: viewsLabel.topAnchor, constant: -10)
        ])
        
        //MARK: - viewsLabel constrsints
        NSLayoutConstraint.activate([
            viewsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            viewsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            viewsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
    }
    
    func setCell(channel: ChannelModel) {
        channelItem = channel
        if let item = channelItem {
            titleLabel.text = item.title
            viewsLabel.text = Formatter.shared.formatViewCount(viewCount: item.subscribers) + " ??????????????????????"
            guard channel.thumbnail != "" else { return }
            if let cachedData = CacheManager.getImageCache(channel.thumbnail) {
                mainImageView.image = UIImage(data: cachedData)
                return
            }
            NetworkManager.retrieveThumbnailWith(url: item.thumbnail) { [weak self] image, url in
                if url.absoluteString != self?.channelItem?.thumbnail {
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
