//
//  UIColor+Helper.swift
//  QCropper
//
//  Created by admin on 2024/10/24.
//

import Foundation

extension QCropWrapper where Base:UIColor{
    /// - Parameters:
    ///   - r: 0~255
    ///   - g: 0~255
    ///   - b: 0~255
    ///   - a: 0~1
    static func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
    
}
