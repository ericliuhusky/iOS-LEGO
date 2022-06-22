//
//  UIImage+Tile.swift
//  LargeImage
//
//  Created by lzh on 2022/6/20.
//

import UIKit

extension UIImage {
    func tiled(outputImageSize: Float, inputTileSize: Float, progressHandler: @escaping (UIImage?) -> Void, completionHandler: @escaping (UIImage?) -> Void) {
        guard let cgImage = cgImage else {
            assertionFailure("")
            return
        }
        let inputWidth = cgImage.width
        let inputHeight = cgImage.height
        let inputPixels = inputWidth * inputHeight
        let pixelsPerMB: Float = 262144
        let outputPixels = outputImageSize * pixelsPerMB
        let scale = outputPixels / Float(inputPixels)
        let tilePixels = inputTileSize * pixelsPerMB
        let inputTileHeight = tilePixels / Float(inputWidth)
        let tileCount = inputHeight / Int(inputTileHeight)
        tiled(scale: scale, tileCount: tileCount, progressHandler: progressHandler, completionHandler: completionHandler)
    }
    
    func tiled(scale: Float, tileCount: Int, progressHandler: @escaping (UIImage?) -> Void, completionHandler: @escaping (UIImage?) -> Void) {
        guard let cgImage = cgImage else {
            assertionFailure("")
            return
        }
        let inputWidth = cgImage.width
        let inputHeight = cgImage.height
        let outputWidth = Int(Float(inputWidth) * scale)
        let outputHeight = Int(Float(inputHeight) * scale)
        
        CGContext.image(width: outputWidth, height: outputHeight) { context in
            let inputTileHeight = inputHeight / tileCount
            let outputTileHeight = Int(Float(inputTileHeight) * scale)
            
            var iterations = tileCount
            
            let remainder = inputHeight % inputTileHeight
            if remainder > 0 {
                iterations += 1
            }
            
            var inputTile = CGRect(x: 0, y: 0, width: inputWidth, height: inputTileHeight)
            var outputTile = CGRect(x: 0, y: 0, width: outputWidth, height: outputTileHeight)
            
            for y in 0..<iterations {
                inputTile.origin.y = CGFloat(y * inputTileHeight)
                outputTile.origin.y = CGFloat(outputHeight - (y + 1) * outputTileHeight)
                
                guard let inputTileImage = cgImage.cropping(to: inputTile) else {
                    assertionFailure("")
                    return
                }
                
                if y == iterations - 1 && remainder > 0 {
                    var dify = outputTile.size.height
                    outputTile.size.height = CGFloat(inputTileImage.height) * CGFloat(scale)
                    dify -= outputTile.size.height
                    outputTile.origin.y += dify
                }
                
                context.draw(inputTileImage, in: outputTile)
                
                if y < iterations - 1 {
                    DispatchQueue.main.async {
                        progressHandler(context.makeUIImage())
                    }
                }
            }
            
            DispatchQueue.main.sync {
                completionHandler(context.makeUIImage())
            }
        }
    }
}

fileprivate extension CGContext {
    private static let bytesPerPixel = 4
    
    static func image(width: Int, height: Int, actions: (CGContext) -> Void) {
        let space = CGColorSpaceCreateDeviceRGB()
        let bytesPerRow = bytesPerPixel * width
        let bytesTotal = bytesPerRow * height
        let data = malloc(bytesTotal)
        defer { free(data) }
        
        guard let context = CGContext(data: data,
                                      width: width,
                                      height: height,
                                      bitsPerComponent: 8,
                                      bytesPerRow: bytesPerRow,
                                      space: space,
                                      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            assertionFailure("")
            return
        }
        
        context.cocoaStyle(CGFloat(height))
        
        actions(context)
    }
    
    func cocoaStyle(_ height: CGFloat) {
        translateBy(x: 0, y: height)
        scaleBy(x: 1, y: -1)
    }
    
    func makeUIImage() -> UIImage? {
        guard let cgImage = makeImage() else {
            assertionFailure("")
            return nil
        }
        
        return UIImage(cgImage: cgImage, scale: 1, orientation: .downMirrored)
    }
}
