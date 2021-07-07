//
//  LocalViewController.swift
//  SVG
//
//  Created by lzh on 2021/6/30.
//

import UIKit

class LocalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(imageView)
    }

    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .init(x: 20, y: 100, width: 100, height: 100))
        
        // 拖入SVG图片，直接使用UIImage(named:)加载图片，内部使用官方私有库CoreSVG
        // 支持iOS12.0+，之前版本未测试
        imageView.image = .init(named: "dog")
        
        
//        // 若根据图片的宽高比，重新调整大小时，需要图片尺寸image.size
//        let imageView = UIImageView(image: .init(named: "dog"))
//        print(imageView.image?.size)
        
        
        // 点击放大
        let tap = UITapGestureRecognizer(target: self, action: #selector(enlarge))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    // 放大事件
    @objc func enlarge() {
        imageView.frame = .init(x: 20, y: 100, width: 300, height: 300)
    }
}
