//
//  UIFont+Helper.swift
//  QCropper
//
//  Created by admin on 2024/10/25.
//


import UIKit

extension QCropWrapper where Base: UIFont {
    
    static func font(ofSize size: CGFloat, bold: Bool = false) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: bold ? .medium : .regular)
    }
    
    static func PingFangRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    static func PingFangBold(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func PingFangSemiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Semibold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func PingFangMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    static func PingFangLight(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    
}
