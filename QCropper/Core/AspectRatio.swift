//
//  AspectRatio.swift
//
//  Created by Chen Qizhi on 2019/10/16.
//

import Foundation

public enum AspectRatio {
    case original
    case freeForm
    case square
    case ratio(width: Int, height: Int)

    var rotated: AspectRatio {
        switch self {
        case let .ratio(width, height):
            return .ratio(width: height, height: width)
        default:
            return self
        }
    }

    var description: String {
        switch self {
        case .original:
            return "ORIGINAL"
        case .freeForm:
            return "FREEFORM"
        case .square:
            return "SQUARE"
        case let .ratio(width, height):
            return "\(width):\(height)"
        }
    }
}

// MARK: Codable

extension AspectRatio: Codable {
    enum CodingKeys: String, CodingKey {
        case description
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let desc = try container.decodeIfPresent(String.self, forKey: .description) else {
            self = .freeForm
            return
        }
        switch desc {
        case "ORIGINAL":
            self = .original
        case "FREEFORM":
            self = .freeForm
        case "SQUARE":
            self = .square
        default:
            let numberStrings = desc.split(separator: ":")
            if numberStrings.count == 2,
                let width = Int(numberStrings[0]),
                let height = Int(numberStrings[1]) {
                self = .ratio(width: width, height: height)
            } else {
                self = .freeForm
            }
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(description, forKey: .description)
    }
}

extension AspectRatio: Equatable {
    public static func == (lhs: AspectRatio, rhs: AspectRatio) -> Bool {
        switch (lhs, rhs) {
        case (let .ratio(lhsWidth, lhsHeight), let .ratio(rhsWidth, rhsHeight)):
            return lhsWidth == rhsWidth && lhsHeight == rhsHeight
        case (.original, .original),
             (.freeForm, .freeForm),
             (.square, .square):
            return true
        default:
            return false
        }
    }
}

public enum XCropProportionEnum: CaseIterable  {
    case original(size: CGSize)
    case custom(size: CGSize)
    case wh1x1, wh3x4, wh4x3, wh9x16, wh16x9, wh2x3, wh3x2, wh4x5, wh5x4, wh5x7, wh7x5
    public static var allCases: [XCropProportionEnum] {
        return [
            .custom(size: .zero),
            .original(size:.zero),
            .wh1x1,
            .wh2x3,
            .wh3x2,
            .wh3x4,
            .wh4x3,
            .wh4x5,
            .wh5x4,
            .wh5x7,
            .wh7x5,
            .wh9x16,
            .wh16x9,
        ]
    }
    
    func toName() -> String {
           switch self {
           case .original:
               return "原比例"
           case .custom:
               return "自由"
           case .wh1x1:
               return "1:1"
           case .wh3x4:
               return "3:4"
           case .wh4x3:
               return "4:3"
           case .wh9x16:
               return "9:16"
           case .wh16x9:
               return "16:9"
           case .wh2x3:
               return "2:3"
           case .wh3x2:
               return "3:2"
           case .wh4x5:
               return "4:5"
           case .wh5x4:
               return "5:4"
           case .wh5x7:
               return "5:7"
           case .wh7x5:
               return "7:5"
           }
       }

       func toImageName() -> String {
           switch self {
           case .original:
               return "whOri"
           case .custom:
               return "whCustom"
           case .wh1x1:
               return "wh1x1"
           case .wh3x4:
               return "wh3x4"
           case .wh4x3:
               return "wh4x3"
           case .wh9x16:
               return "wh9x16"
           case .wh16x9:
               return "wh16x9"
           case .wh2x3:
               return "wh2x3"
           case .wh3x2:
               return "wh3x2"
           case .wh5x4:
               return "wh5x4"
           case .wh4x5:
               return "wh4x5"
           case .wh5x7:
               return "wh5x7"
           case .wh7x5:
               return "wh7x5"
           }
           
       }
    
    var whRatio: CGFloat {
           switch self {
           case .original(let size):
               return size.width / size.height // 可以根据需求返回原始比例，也可以用其他表示方式
           case .custom(let size):
               return 0 // 自定义比例，这里返回0，具体比例需要用户输入
           case .wh1x1:
               return 1.0 / 1.0
           case .wh3x4:
               return 3.0 / 4.0
           case .wh4x3:
               return 4.0 / 3.0
           case .wh9x16:
               return 9.0 / 16.0
           case .wh16x9:
               return 16.0 / 9.0
           case .wh2x3:
               return 2.0 / 3.0
           case .wh3x2:
               return 3.0 / 2.0
           case .wh4x5:
               return 4.0 / 5.0
           case .wh5x4:
               return 5.0 / 4.0
           case .wh5x7:
               return 5.0 / 7.0
           case .wh7x5:
               return 7.0 / 5.0
           }
       }
    
   public var UMClickName: String {
        switch self {
        case .original:
            return "origin" // 可以根据需求返回原始比例，也可以用其他表示方式
        case .custom:
            return "free" // 自定义比例，这里返回0，具体比例需要用户输入
        case .wh1x1:
            return "1_1"
        case .wh3x4:
            return "3_4"
        case .wh4x3:
            return "4_3"
        case .wh9x16:
            return "9_16"
        case .wh16x9:
            return "16_9"
        case .wh2x3:
            return "2_3"
        case .wh3x2:
            return "3_2"
        case .wh4x5:
            return "4_5"
        case .wh5x4:
            return "5_4"
        case .wh5x7:
            return "5_7"
        case .wh7x5:
            return "7_5"
        }
    }

    
    func updateSize(to newSize: CGSize) -> XCropProportionEnum {
          switch self {
          case .original:
              return .original(size: newSize)
          case .custom:
              return .custom(size: newSize)
          default:
              return self
          }
      }
    
}

extension XCropProportionEnum: Equatable {
    public static func == (lhs: XCropProportionEnum, rhs: XCropProportionEnum) -> Bool {
        return lhs.toName() == rhs.toName()
    }
}

public enum XClipSegmentTap:Int,CaseIterable  {
        case clip,rotate
    func toName() -> String {
        switch self {
        case .clip:
            return "裁剪"
        case .rotate:
            return "旋转"
        }
    }
    

}


public enum XCropRotateEnum: CaseIterable  {
    case cropLeft, cropRight,cropHor,cropVer
    
    public static var allCases: [XCropRotateEnum] {
        return [
            .cropLeft,
            .cropRight,
            .cropHor,
            .cropVer,
        ]
    }
    
    func toName() -> String {
        switch self {
        case .cropLeft:
            return "向左90"
        case .cropRight:
            return "向右90"
        case .cropHor:
            return "水平翻转"
        case .cropVer:
            return "垂直翻转"
        }
    }
    // 方法：将 XCropRotateEnum 映射到 UIImage.Orientation
     public func toImageOrientation() -> UIImage.Orientation {
          switch self {
          case .cropLeft:
              return .left
          case .cropRight:
              return .right
          case .cropHor:
              return .upMirrored
          case .cropVer:
              return .downMirrored
          }
      }
    
        func toImageName() -> String {
            switch self {
            case .cropLeft:
                return "QCropper.crop.left"
            case .cropRight:
                return "QCropper.crop.right"
            case .cropHor:
                return "QCropper.crop.hor"
            case .cropVer:
                return "QCropper.crop.ver"
            }
        }
    
  
    public var UMClickName:String {
        switch self {
        case .cropLeft:
            return "left90"
        case .cropRight:
            return "right90"
        case .cropHor:
            return "horizontal"
        case .cropVer:
            return "vertical"
        }
    }

}

