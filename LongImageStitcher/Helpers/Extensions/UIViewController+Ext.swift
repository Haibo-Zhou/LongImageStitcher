//
//  UIViewController+Ext.swift
//  LongImageStitcher
//
//  Created by HaiboZhou on 2021/9/26.
//

import UIKit

fileprivate var aView: UIView?

extension UIViewController {
    
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = .clear
        let ai = UIActivityIndicatorView(style: .large)
        ai.color = .systemPink
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
    }
    
    func removeSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
    
    func setBackgroundImage(imageName: String) {
        let bgImage = UIImage(named: imageName)
        
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = bgImage
        imageView.center = self.view.center
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
}
