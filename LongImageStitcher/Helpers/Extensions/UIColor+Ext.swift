//
//  UIColor+Ext.swift
//  WeChat Clone
//
//  Created by HaiboZhou on 2021/9/14.
//

import UIKit

extension UIColor {
    // color components value between 0 to 255
    public convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    static let myBlue: UIColor = UIColor(r: 40, g: 102, b: 191)
    static let myGreen: UIColor = UIColor(r: 34, g: 181, b: 115)
    static let myFolderBlue: UIColor = UIColor(r: 114, g: 208, b: 250)
    static let myYellow: UIColor = UIColor(r: 255, g: 209, b: 16)
    static let myPuple: UIColor = UIColor(r: 164, g: 42, b: 255)
    static let myPink: UIColor = UIColor(r: 252, g: 209, b: 210)
    static let myEmailBlue: UIColor = UIColor(r: 29, g: 120, b: 242)
    
    // a gray/black color for ChatLog page background
    static let chatLogBgColor: UIColor = UIColor(named: "chatLogBgColor")!
    // the green bg color for chat message bubble
    static let msgGreenBgColor: UIColor = UIColor(named: "msgGreenBgColor")!
    // the gray bg color for chat message bubble
    static let msgGrayBgColor: UIColor = UIColor(named: "msgGrayBgColor")!
    
    static let myBlueHexcode: UInt = 0x2866BF
    static let myGreenHexcode: UInt = 0x28B473
    static let myFolderBlueHexcode: UInt = 0x72D0FA
    static let myYellowHexcode: UInt = 0xFFD110
    static let myPupleHexcode: UInt = 0xA42AFF
    static let myPinkHexcode: UInt = 0xFCD1D2
}
