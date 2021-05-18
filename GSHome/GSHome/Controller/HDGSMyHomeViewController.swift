//
//  HDGSMyHomeViewController.swift
//  GSHome
//
//  Created by lzh on 2021/5/13.
//

import UIKit
import SDWebImage

// 模拟数据
let hdgsMock = HDGSMyHomeMock()

class HDGSMyHomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        // 设置每一个collcetionCell的尺寸
        collectionViewLayout.itemSize = CGSize(width: 168, height: 236)
        // 只有设置了额外视图的尺寸，才会调用额外数据源
        collectionViewLayout.headerReferenceSize = CGSize(width: 465, height: 68)
        
        collectionViewLayout.minimumLineSpacing = 9
        collectionViewLayout.minimumInteritemSpacing = 15
        
        return collectionViewLayout
    }()
    
    // MARK: 注意是闭包，不是计算属性
    lazy var collectionView: UICollectionView = {
        // collectionView必须有Layout
        let collectionView = UICollectionView(frame: CGRect(x: 99, y: 0, width: UIScreen.main.bounds.width - 99, height: UIScreen.main.bounds.height), collectionViewLayout: self.collectionViewLayout)
        collectionView.backgroundColor = .white
        collectionView.register(HDGSMyHomeCollectionCellView.self, forCellWithReuseIdentifier: NSStringFromClass(HDGSMyHomeCollectionCellView.self))
        collectionView.register(HDGSMyHomeCollectionSectionTitleView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(HDGSMyHomeCollectionSectionTitleView.self))
        
        return collectionView
    }()
    
    var tabbarView: UIView = {
        let tabbarView = UIView(frame: CGRect(x: 0, y: 0, width: 99, height: 810))
        tabbarView.backgroundColor = .white
        return tabbarView
    }()
    
    var dataSource: [[HDGSMyHomeCollectionCellModel]] = hdgsMock.refersh()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        self.view.addSubview(collectionView)
        self.view.addSubview(tabbarView)
    }

    // MARK: UICollectionViewDataSource
    
    // 分组数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }

    // 每个分组cell的数目
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].count
    }

    // 数据
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(HDGSMyHomeCollectionCellView.self), for: indexPath) as! HDGSMyHomeCollectionCellView

        let data = dataSource[indexPath.section][indexPath.item]

        // 为cell设置数据
        cell.imageView.sd_setImage(with: URL(string: data.imageURL)!, placeholderImage: UIImage(named: "vip_avatar_login_default"))
        cell.titleLabel.text = data.title
        cell.episodeLabel.text = data.episode
        if let description = data.description {
            cell.descriptionLabel.text = description
        }
        if let badgeImageName = data.badgeImageName {
            cell.badgeImageView.image = UIImage(named: badgeImageName)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionTitle = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(HDGSMyHomeCollectionSectionTitleView.self), for: indexPath) as! HDGSMyHomeCollectionSectionTitleView
            let data = dataSource[indexPath.section]

            sectionTitle.titleLabel.text = "分组标题"
            return sectionTitle
        }
        
        return UICollectionReusableView()
    }
}

extension HDGSMyHomeViewController: UIScrollViewDelegate {
    
    // 只要滚动视图滚动了就会监听
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    // 只有用户滑动手势结束时才监听滚动视图的值，防止下拉刷新多次
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y <= -50 {
            print("下拉刷新")

            dataSource = hdgsMock.refersh()
            collectionView.reloadData()
        }

        // scrollView偏移 + collectionView高度 - scrollView高度
        // tips~: collectionView的frame是固定的尺寸，scrollView的contentSize会根据内容撑开而更改
        if (scrollView.contentOffset.y + UIScreen.main.bounds.height - scrollView.contentSize.height) >= 50 {
            print("加载更多")

            dataSource = hdgsMock.loadMore()
            collectionView.reloadData()
        }
    }
}
