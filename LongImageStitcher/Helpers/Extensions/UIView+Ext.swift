//
//  UIView+Ext.swift
//  LongImageStitcher
//
//  Created by HaiboZhou on 2021/9/25.
//

import UIKit

extension UIView {
    /**
     Rotate a view by specified degrees
     
     - parameter angle: angle in degrees
     */
    func rotate(angle: CGFloat) {
        let radians = angle / 180 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
    }
    
    /**
     Add gradient effect on front of an UIView
     
     - parameter angle: angle in degrees
     */
    func addGradient(color1: UIColor, color2: UIColor) {
        let gradientView = UIView(frame: self.bounds)
        let gradient = CAGradientLayer()
        gradient.frame = gradientView.frame
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.0, 1.0]
        gradientView.layer.insertSublayer(gradient, at: 0)
        self.addSubview(gradientView)
        self.bringSubviewToFront(gradientView)
    }
}
