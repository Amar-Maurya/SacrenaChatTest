//
//  UIView+Extension.swift
//  SacrenaChat
//

import UIKit

extension UIView {
    func setCornerRadii(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        let path = UIBezierPath()
        let width = frame.width
        let height = frame.height
        
        // Start from the top-left corner
        path.move(to: CGPoint(x: topLeft, y: 0))
        
        // Top-right corner
        path.addLine(to: CGPoint(x: width - topRight, y: 0))
        path.addArc(withCenter: CGPoint(x: width - topRight, y: topRight), radius: topRight, startAngle: -CGFloat.pi / 2, endAngle: 0, clockwise: true)
        
        // Bottom-right corner
        path.addLine(to: CGPoint(x: width, y: height - bottomRight))
        path.addArc(withCenter: CGPoint(x: width - bottomRight, y: height - bottomRight), radius: bottomRight, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
        
        // Bottom-left corner
        path.addLine(to: CGPoint(x: bottomLeft, y: height))
        path.addArc(withCenter: CGPoint(x: bottomLeft, y: height - bottomLeft), radius: bottomLeft, startAngle: CGFloat.pi / 2, endAngle: CGFloat.pi, clockwise: true)
        
        // Top-left corner again
        path.addLine(to: CGPoint(x: 0, y: topLeft))
        path.addArc(withCenter: CGPoint(x: topLeft, y: topLeft), radius: topLeft, startAngle: CGFloat.pi, endAngle: -CGFloat.pi / 2, clockwise: true)
        
        path.close()
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
        self.clipsToBounds = true
        self.layoutIfNeeded()
    }
}

