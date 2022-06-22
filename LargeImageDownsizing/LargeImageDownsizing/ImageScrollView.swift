//
//  ImageScrollView.swift
//  LargeImage
//
//  Created by lzh on 2022/6/22.
//

import UIKit

class ImageScrollView: UIScrollView, UIScrollViewDelegate {
    // 最前的瓦片图
    var frontTiledView: TiledImageView!
    // 旧瓦片图，缩放结束时在其上绘制新的瓦片图
    var backTiledView: TiledImageView?
    // 在瓦片图渲染内容前展示的低分辨率版本的图像
    var backgroundImageView: UIImageView!
    var minimumScale: CGFloat = 0
    // 当前缩放比率
    var imageScale: CGFloat = 0
    var image: UIImage?
    
    init(frame: CGRect, image: UIImage?) {
        super.init(frame: frame)
        // 设置UIScrollView
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        bouncesZoom = true
        decelerationRate = .fast
        delegate = self
        maximumZoomScale = 5
        minimumZoomScale = 0.25
        backgroundColor = .init(red: 0.4, green: 0.2, blue: 0.2, alpha: 1.0)
        
        // 图像尺寸
        self.image = image
        var imageRect = CGRect(x: 0, y: 0, width: image!.cgImage!.width, height: image!.cgImage!.height)
        imageScale = frame.size.width / imageRect.size.width
        minimumScale = imageScale * 0.75
        print("imageScale: \(imageScale)")
        imageRect.size = imageRect.size.applying(.init(scaleX: imageScale, y: imageScale))
        
        // 创建在瓦片图渲染内容前展示的低分辨率图像
        UIGraphicsBeginImageContext(imageRect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        context?.draw(image!.cgImage!, in: imageRect)
        context?.restoreGState()
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        backgroundImageView = UIImageView()
        backgroundImageView.image = backgroundImage
        backgroundImageView.frame = imageRect
        backgroundImageView.contentMode = .scaleAspectFit
        addSubview(backgroundImageView)
        sendSubviewToBack(backgroundImageView)
        
        // 创建瓦片图
        frontTiledView = TiledImageView(frame: imageRect, image: image, scale: imageScale)
        addSubview(frontTiledView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 用layoutSubviews来使图像居中
    override func layoutSubviews() {
        super.layoutSubviews()
        // 图像尺寸小于屏幕时居中
        let boundsSize = bounds.size
        var frameToCenter = frontTiledView.frame
        
        // 横向居中
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }
        
        // 纵向居中
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
        
        frontTiledView.frame = frameToCenter
        backgroundImageView.frame = frameToCenter
        frontTiledView.contentScaleFactor = 1.0
    }
    
    // 将会被缩放的视图
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        frontTiledView
    }
    
    // 停止缩放时，基于新的缩放等级创建一个新的瓦片图，并在旧的瓦片图上绘制
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        // 设置瓦片图的新缩放因子
        imageScale *= scale
        if imageScale < minimumScale {
            imageScale = minimumScale
        }
        
        var imageRect = CGRect(x: 0, y: 0, width: image!.cgImage!.width, height: image!.cgImage!.height)
        imageRect.size = imageRect.size.applying(.init(scaleX: imageScale, y: imageScale))
        
        // 创建新的瓦片图
        frontTiledView = TiledImageView(frame: imageRect, image: image, scale: imageScale)
        addSubview(frontTiledView)
    }
    
    // 开始缩放时，删除旧瓦片图，并将当前的瓦片图设置为旧瓦片图
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        // 删除旧瓦片图
        backTiledView?.removeFromSuperview()
        // 将当前的瓦片图设置为旧瓦片图
        backTiledView = frontTiledView
    }
}
