//
//  QCropWrapper.swift
//  QCropper
//
//  Created by admin on 2024/10/24.
//

import Foundation
import UIKit


public struct QCropWrapper<Base> {
    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol QCropCompatible: AnyObject { }

public protocol QCropCompatibleValue { }

extension QCropCompatible {
    public var qc: QCropWrapper<Self> {
        get { QCropWrapper(self) }
        set { }
    }
    
    public static var qc: QCropWrapper<Self>.Type {
        get { QCropWrapper<Self>.self }
        set { }
    }
}

extension QCropCompatibleValue {
    public var qc: QCropWrapper<Self> {
        get { QCropWrapper(self) }
        set { }
    }
}

extension UIViewController: QCropCompatible { }
extension UIColor: QCropCompatible { }
extension UIImage: QCropCompatible { }
extension CIImage: QCropCompatible { }
extension UIFont: QCropCompatible { }
extension UIView: QCropCompatible { }
extension UIGraphicsImageRenderer: QCropCompatible { }

extension Array: QCropCompatibleValue { }
extension String: QCropCompatibleValue { }
extension CGFloat: QCropCompatibleValue { }
extension Bool: QCropCompatibleValue { }

