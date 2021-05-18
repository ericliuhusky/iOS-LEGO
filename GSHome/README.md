# 日报

## 任务内容

使用`UICollectionView`实现类似于故事首页的热门推荐板块的内容，除了注册基本的`UICollectionViewCell`用来承载集合
视图中每一个格子的内容以外，还要注册额外的头部supplementaryView用以展示分组标题。使用`UICollectionView`父类`UIScrollView`
的代理方法控制集合视图下拉刷新，上拉触底加载更多实现无限下拉。其中每个格子的图片使用`SDWebImage`来加载网络图片，数据均使用模拟数据

## 知识总结

1. 圆角效果

```swift
view.layer.cornerRadius = 12
view.layer.masksToBounds = true
```

2. 额外的头部或底部视图

```swift
// UICollectionViewCell继承自UICollectionReusableView，相当于在更底层的类上定制额外header
class HeaderTitleView: UICollectionReusableView {
    // override init and required init, then do some custom definition
}

collectionView.register(HeaderTitleView.self, 
                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, 
                        withReuseIdentifier: NSStringFromClass(HeaderTitleView.self))

class ViewController {
    override func viewDidLoad() {
        collectionView.dataSource = self
        self.view.addSubView(collectionView)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, 
                        viewForSupplementaryElementOfKind kind: String, 
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, 
            withReuseIdentifier: NSStringFromClass(HeaderTitleView.self), for: indexPath) as! HeaderTitleView
            // assign data to header view
            return header
        }

        return UICollectionReusableView()
    }
}
```

3. `UICollectionViewCell`

```swift
class CollectionViewCell: UICollectionViewCell {
    // override init and required init, then do some custom definition
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 子视图要加在contentView中
        self.contentView.addSubView(aSubViewForExample)
    }
}

collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(CollectionViewCell.self))

class ViewController {
    override func viewDidLoad() {
        collectionView.dataSource = self
        self.view.addSubView(collectionView)
    }
}

extension ViewController: UICollectionViewDataSource {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(CollectionViewCell.self),
                                                      for: indexPath) as! CollectionViewCell

        let data = dataSource[indexPath.section][indexPath.item]
        // assign data to cell view
        return cell
    }
}
```

4. `UICollectionView` 一定要有 `UICollectionViewFlowLayout`

```swift
let layout = UICollectionViewFlowLayout()
// 每个cell的宽高
layout.itemSize = CGSize(width: 100, height: 100)
// 只有设置了额外视图的尺寸，才会调用额外数据源
layout.headerReferenceSize = CGSize(width: 500, height: 70)
// 最小行间距
layout.minimumLineSpacing = 10
// 最小cell间距
layout.minimumInteritemSpacing = 10
let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
```

5. `UIScrollViewDelegate`

```swift
class ViewController {
    override func viewDidLoad() {
        collectionView.delegate = self
        self.view.addSubView(collectionView)
    }
}

extension ViewController: UIScrollViewDelegate {
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
```

6. `SDWebImage`

```swift
imageView.sd_setImage(with: URL(string: "imageURL")!)
```
