//
//  HDGSMyHomeCollectionCellView.swift
//  GSHome
//
//  Created by lzh on 2021/5/13.
//

import UIKit

class HDGSMyHomeCollectionCellView: UICollectionViewCell {
    // 图片
    var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 168, height: 168))
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    // 右上角徽标
    var badgeImageView: UIImageView = {
        let badgeImageView = UIImageView(frame: CGRect(x: 128, y: 0, width: 40, height: 20))
        return badgeImageView
    }()
    
    // 集数
    var episodeLabel: UILabel = {
        let episodeLabel = UILabel(frame: CGRect(x: 10, y: 138, width: 36.5, height: 20))
        episodeLabel.font = .systemFont(ofSize: 13)
        episodeLabel.textColor = .rgb(red: 107, green: 12, blue: 5)
        episodeLabel.backgroundColor = .white
        episodeLabel.layer.cornerRadius = 4
        episodeLabel.layer.masksToBounds = true
        episodeLabel.textAlignment = .center
        return episodeLabel
    }()
    
    // 标题
    var titleLabel: UILabel = {
        let titleLable = UILabel(frame: CGRect(x: 0, y: 184, width: 168, height: 18))
        titleLable.font = .systemFont(ofSize: 18)
        titleLable.textColor = .rgb(red: 51, green: 51, blue: 51)
        return titleLable
    }()
    
    // 描述
    var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel(frame: CGRect(x: 0, y: 214, width: 168, height: 14))
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textColor = .rgb(red: 102, green: 102, blue: 102)
        return descriptionLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.addSubview(badgeImageView)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(episodeLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) has not been implemented")
    }
}

extension UIColor {
    // 仅在本文件内部使用扩展
    fileprivate class func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}
