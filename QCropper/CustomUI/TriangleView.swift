//
//  TriangleView.swift
//  QCropper
//
//  Created by admin on 2024/10/25.
//

import UIKit

class TriangleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTriangle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTriangle()
    }
    
    private func setupTriangle() {
        // 创建一个CAShapeLayer来绘制三角形
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.white.cgColor // 设置三角形颜色为白色
        
        // 创建一个UIBezierPath来定义三角形的路径
        let path = UIBezierPath()
        path.move(to: CGPoint(x: frame.width / 2, y: 0)) // 顶部顶点
        path.addLine(to: CGPoint(x: frame.width, y: frame.height)) // 右下角
        path.addLine(to: CGPoint(x: 0, y: frame.height)) // 左下角
        path.close() // 闭合路径
        
        shapeLayer.path = path.cgPath
        self.layer.addSublayer(shapeLayer)
    }
}
