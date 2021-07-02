//
//  RoundedButton.swift
//  RoundedButton
//
//  Created by lzh on 2021/7/1.
//

import UIKit

class RoundedButton: UIView {
    struct CornerRect {
        var topLeft: CGFloat
        var topRight: CGFloat
        var bottomLeft: CGFloat
        var bottomRight: CGFloat
    }
    
    func cornerRadius(_ radius: CGFloat) {
        withCornerRadius(radius)
    }
    
    func cornerRadius(rect radius: CornerRect) {
        withBezierPath(rect: radius)
        switch radius {
        case let radius where allSidesEqual(radius):
            withCornerRadius(radius.topLeft)
        default:
            withBezierPath(rect: radius)
            break
        }
    }
    
    
    // 判断所有边相等
    private func allSidesEqual(_ radius: CornerRect) -> Bool {
        return radius.topLeft == radius.topRight
            && radius.bottomLeft == radius.bottomRight
            && radius.topLeft == radius.bottomLeft
    }
    
    // 使用cornerRadius
    private func withCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    // 使用贝塞尔曲线
    private func withBezierPath(rect radius: CornerRect) {
        let topLeftFrame = CGRect(x: 0, y: 0, width: frame.width / 2, height: frame.height / 2)
        let topRightFrame = CGRect(x: frame.width / 2, y: 0, width: frame.width / 2, height: frame.height / 2)
        let bottomLeftFrame = CGRect(x: 0, y: frame.height / 2, width: frame.width / 2, height: frame.height / 2)
        let bottomRightFrame = CGRect(x: frame.width / 2, y: frame.height / 2, width: frame.width / 2, height: frame.height / 2)
        let topLeftRadius = CGSize(width: radius.topLeft, height: radius.topLeft)
        let topRightRadius = CGSize(width: radius.topRight, height: radius.topRight)
        let bottomLeftRadius = CGSize(width: radius.bottomLeft, height: radius.bottomLeft)
        let bottomRightRadius = CGSize(width: radius.bottomRight, height: radius.bottomRight)
        
        let topLeftPath = UIBezierPath(roundedRect: topLeftFrame, byRoundingCorners: .topLeft, cornerRadii: topLeftRadius)
        let topRightPath = UIBezierPath(roundedRect: topRightFrame, byRoundingCorners: .topRight, cornerRadii: topRightRadius)
        let bottomLeftPath = UIBezierPath(roundedRect: bottomLeftFrame, byRoundingCorners: .bottomLeft, cornerRadii: bottomLeftRadius)
        let bottomRightPath = UIBezierPath(roundedRect: bottomRightFrame, byRoundingCorners: .bottomRight, cornerRadii: bottomRightRadius)
        topLeftPath.append(topRightPath)
        topLeftPath.append(bottomLeftPath)
        topLeftPath.append(bottomRightPath)
        
        let layer = CAShapeLayer()
        layer.path = topLeftPath.cgPath
        self.layer.mask = layer
    }

}
