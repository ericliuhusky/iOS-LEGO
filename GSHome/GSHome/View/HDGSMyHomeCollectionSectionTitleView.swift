//
//  HDGSMyHomeCollectionSectionTitleView.swift
//  GSHome
//
//  Created by lzh on 2021/5/17.
//

import UIKit

class HDGSMyHomeCollectionSectionTitleView: UICollectionReusableView {
    var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        titleLabel.font = .systemFont(ofSize: 24)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) has not been implemented")
    }
}
