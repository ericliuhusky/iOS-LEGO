//
//  TiledImageView.swift
//  LargeImage
//
//  Created by lzh on 2022/6/22.
//

import UIKit

class TiledImageView: UIView {
    var imageScale: CGFloat
    var image: UIImage
    var imageRect: CGRect
    
    init(frame: CGRect, image: UIImage?, scale: CGFloat) {
        self.image = image!
        imageRect = CGRect(x: 0, y: 0, width: image!.cgImage!.width, height: image!.cgImage!.height)
        imageScale = scale
        super.init(frame: frame)
        let tiledLayer = layer as! CATiledLayer
        tiledLayer.levelsOfDetail = 4
        tiledLayer.levelsOfDetailBias = 4
        tiledLayer.tileSize = CGSize(width: 512, height: 512)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        CATiledLayer.self
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        context?.scaleBy(x: imageScale, y: imageScale)
        context?.draw(image.cgImage!, in: imageRect)
        context?.restoreGState()
    }
}
