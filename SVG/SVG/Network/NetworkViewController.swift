//
//  NetworkViewController.swift
//  SVG
//
//  Created by lzh on 2021/6/30.
//

import UIKit

import SDWebImage
import SDWebImageSVGCoder
import SDWebImageSVGKitPlugin

class NetworkViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if #available(iOS 13.0, *) {
            // 13.0+使用CoreSVG
            let SVGCoder = SDImageSVGCoder.shared
            SDImageCodersManager.shared.addCoder(SVGCoder)
        } else {
            // 之前版本使用第三方库SVGKit，这里是SDImage的一个封装
            let SVGCoder = SDImageSVGKCoder.shared
            SDImageCodersManager.shared.addCoder(SVGCoder)
        }
        
        view.addSubview(imageView)
    }

    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .init(x: 20, y: 100, width: 100, height: 100))
        
        // 13.0+使用CoreSVG，之前使用SVGKit
        imageView.sd_setImage(with: .init(string: "https://upload.wikimedia.org/wikipedia/commons/7/76/Autism_spectrum_infinity_awareness_symbol.svg"))
        
        
//        // 若根据图片的宽高比，重新调整大小时，需要图片尺寸image.size
//        imageView.sd_setImage(with: .init(string: "https://upload.wikimedia.org/wikipedia/commons/7/76/Autism_spectrum_infinity_awareness_symbol.svg")) { image, _, _, _ in
//            print(image?.size)
//        }
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(enlarge))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    @objc func enlarge() {
        imageView.frame = .init(x: 20, y: 100, width: 300, height: 300)
    }
}
