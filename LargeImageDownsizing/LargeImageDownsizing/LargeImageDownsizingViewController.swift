//
//  LargeImageDownsizingViewController.swift
//  LargeImage
//
//  Created by lzh on 2022/6/20.
//

import UIKit

class LargeImageDownsizingViewController: UIViewController {
    
    // 输入图像
    var sourceImage: UIImage!
    // 输出图像
    // destImage是线程安全的，因为它是从主线程访问的。
    var destImage: UIImage!
    // 表示一次性加载到内存的最大像素数据量的输入图像边界的子矩形
    var sourceTile: CGRect = .zero
    // 与sourceTile相关的输出图像的子矩形
    var destTile: CGRect = .zero
    // 输入图像与输出图像的大小之比。
    var imageScale: Float = 0
    // 输入图像宽高
    var sourceResolution: CGSize = .zero
    // 输入图像中的总像素数
    var sourceTotalPixels: Float = 0
    // 输入图像中未压缩像素数据的总兆字节数。
    var sourceTotalMB: Float = 0
    // 输出图像宽高
    var destResolution: CGSize = .zero
    // 用于保存生成的输出图像像素数据的临时容器
    var destContext: CGContext!
    // the number of pixels to overlap tiles as they are assembled.
    var sourceSeemOverlap: Float = 0
    // 显示缩小后图像的滚动视图
    var scrollView: ImageScrollView!
    
    var progressView: UIImageView!

    func downsize() {
        // 使用图像文件名创建图像，现在并不实际从磁盘读取任何像素信息，在绘制时期才实际读取
        sourceImage = UIImage(contentsOfFile: Bundle.main.path(forResource: imageFilename, ofType: nil)!)!
        sourceResolution.width = CGFloat(sourceImage.cgImage!.width)
        sourceResolution.height = CGFloat(sourceImage.cgImage!.height)
        // 计算输入图像的总像素个数
        sourceTotalPixels = Float(sourceResolution.width) * Float(sourceResolution.height)
        // 计算在内存中存储解压图像所需要的MB大小
        sourceTotalMB = sourceTotalPixels / pixelsPerMB
        // 确定为了生成已定义的图像大小，应用于输入图像的比率
        imageScale = destTotalPixels / sourceTotalPixels
        // 使用图像比率计算输出图像的宽高
        destResolution.width = floor(sourceResolution.width * CGFloat(imageScale))
        destResolution.height = floor(sourceResolution.height * CGFloat(imageScale))
        // 创建一个持有输出图像像素数据的离屏位图上下文
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bytesPerRow = Int(bytesPerPixel * Float(destResolution.width))
        let bytesTotal = Int(Float(bytesPerRow) * Float(destResolution.height))
//        let destBitmapData = UnsafeMutableRawPointer.allocate(byteCount: bytesTotal, alignment: bytesPerRow)
        let destBitmapData = malloc(bytesTotal)
        defer {
//            destBitmapData.deallocate()
            free(destBitmapData)
        }
        destContext = CGContext(data: destBitmapData, width: Int(destResolution.width), height: Int(destResolution.height), bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        // 翻转输出图形上下文，使其与输入图像的Cocoa风格方向对齐
        // 这是有必要的，因为我们使用Cocoa的UIImage(named:)来打开输入文件
        destContext.translateBy(x: 0, y: destResolution.height)
        destContext.scaleBy(x: 1, y: -1)
        
        // now define the size of the rectangle to be used for the
        // incremental blits from the input image to the output image.
        // 由于iOS从磁盘读取图像数据的方式，我们让图像分割贴片的宽度等于输入图像的宽度
        // iOS必须以全宽度'bands'解码磁盘中的图像，即使当前图形上下文被裁剪到子矩形
        // 因此我们通过将图像分割贴片的大小调整为输入图像的全宽，来充分利用解码操作产生的所有像素数据
        sourceTile.size.width = sourceResolution.width;
        // 图像分割贴片的高度是动态的。 因为我们指定了输入图像分割贴片的MB大小，计算给定宽度下的像素高度
        sourceTile.size.height = floor((CGFloat(tileTotalPixels) / sourceTile.size.width))
        print("source tile size: \(sourceTile.size.width) x \(sourceTile.size.height)")
        sourceTile.origin.x = 0
        
        // 输出图像分割贴片的尺寸为输入图像分割贴片的尺寸乘imageScale
        destTile.size.width = destResolution.width
        destTile.size.height = sourceTile.size.height * CGFloat(imageScale)
        destTile.origin.x = 0
        print("dest tile size: \(destTile.size.width) x \(destTile.size.height)")
        
        // sourceSeemOverlap与destSeemOverlap成比例
        // 这是在组装输出图像时图像分割贴片重叠的像素数
        sourceSeemOverlap = floor(Float(destSeemOverlap / destResolution.height * sourceResolution.height))
        print("dest seem overlap: \(destSeemOverlap), source seem overlap: \(sourceSeemOverlap)")
        
        // 计算组装输出图像需要的读写迭代次数
        var iterations = Int(sourceResolution.height / sourceTile.size.height)
        
        // 如果图像分割贴片高度不能整除图像高度，为剩下的像素添加另一次迭代
        let remainder = Int(sourceResolution.height) % Int(sourceTile.size.height)
        if remainder > 0 {
            iterations += 1
        }
        
        // 将重叠的像素数添加到图像分割贴片，为y坐标计算保留原始图像分割贴片高度
        let sourceTileHeightMinusOverlap = Float(sourceTile.size.height)
        sourceTile.size.height += CGFloat(sourceSeemOverlap)
        destTile.size.height += destSeemOverlap
        print("beginning downsize. iterations: \(iterations), tile height: \(sourceTile.size.height), remainder height: \(remainder)")
        
        for y in 0..<iterations {
            print("iteration \(y + 1) of \(iterations)")
            sourceTile.origin.y = CGFloat(Float(y) * sourceTileHeightMinusOverlap + sourceSeemOverlap)
            destTile.origin.y = destResolution.height - (CGFloat(y + 1) * CGFloat(sourceTileHeightMinusOverlap) * CGFloat(imageScale) + destSeemOverlap)
            // 创建输入图像的引用，并将其上下文裁剪到参数rect
            let sourceTileImageRef = sourceImage.cgImage!.cropping(to: sourceTile)!
            // 如果是最后一个图像分割贴片，它的尺寸可能小于输入图像分割贴片的高度
            // 调整destTile大小以考虑该差异
            if y == iterations - 1 && remainder > 0 {
                var dify = destTile.size.height
                destTile.size.height = CGFloat(sourceTileImageRef.height) * CGFloat(imageScale)
                dify -= destTile.size.height
                destTile.origin.y += dify
            }
            
            // 从输入图像读图像分割贴片大小的像素，写到输出图像
            destContext.draw(sourceTileImageRef, in: destTile)
            
            if y < iterations - 1 {
                sourceImage = UIImage(contentsOfFile: Bundle.main.path(forResource: imageFilename, ofType: nil)!)!
                DispatchQueue.main.async {
                    self.updateScrollView()
                }
            }
        }
        
        print("downsize complete.")
        
        DispatchQueue.main.sync {
            self.initializeScrollView()
        }
    }
    
    func initializeScrollView() {
        progressView.removeFromSuperview()
        createImageFromContext()
        // 创建scrollView来展示生成的图像
        scrollView = ImageScrollView(frame: view.bounds, image: destImage)
        view.addSubview(scrollView)
    }
    
    func updateScrollView() {
        createImageFromContext()
        
        progressView.image = destImage
    }
    
    func createImageFromContext() {
        // 从离屏图形上下文创建CGImage
        let destImageRef = destContext.makeImage()!
        destImage = UIImage(cgImage: destImageRef, scale: 1, orientation: .downMirrored)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView = UIImageView(frame: view.bounds)
        view.addSubview(progressView)
        
        sourceImage = UIImage(contentsOfFile: Bundle.main.path(forResource: imageFilename, ofType: nil)!)!
        DispatchQueue.global().async {
            self.sourceImage.tiled(scale: 0.22, tileCount: 13) { image in
                self.progressView.image = image
            } completionHandler: { image in
                self.progressView.removeFromSuperview()
                self.scrollView = ImageScrollView(frame: self.view.bounds, image: image)
                self.view.addSubview(self.scrollView)
            }

        }
    }
}
