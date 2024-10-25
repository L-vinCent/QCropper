//
//  CropSegmentView.swift
//  QCropper
//
//  Created by admin on 2024/10/24.
//

import Foundation
import UIKit

class CropSegmentView:UIView{

    private var buttons = [UIButton]()
    private let indicatorView = UIView()
    private var buttonTapHandler: ((XClipSegmentTap) -> Void)?
    public var titles:[XClipSegmentTap] = []

    convenience init(frame: CGRect, titles: [XClipSegmentTap] , buttonTapHandler: ((XClipSegmentTap) -> Void)?) {
        self.init()
        self.titles = titles
        self.buttonTapHandler = buttonTapHandler
        setupButtons(with: titles)
        setupIndicatorView()
    }


    override func layoutSubviews() {
        super.layoutSubviews()
        layoutStackViewAndButtons()
        layoutIndicatorView()
    }
    //设置按钮
    private func setupButtons(with titles: [XClipSegmentTap]) {
           // 如果按钮已经存在，直接返回
           guard buttons.isEmpty else { return }

           let buttonWidth = 36.0
           let stackView = UIStackView()
           stackView.axis = .horizontal
           stackView.alignment = .fill
           stackView.distribution = .fillEqually
           stackView.isLayoutMarginsRelativeArrangement = true

           for (_, type) in titles.enumerated() {
               let button = UIButton(type: .custom)
               button.setTitle(type.toName(), for: .normal)
               button.setTitleColor(.qc.rgba(102, 102, 102), for: .normal)
               button.setTitleColor(.white, for: .selected)
               button.titleLabel?.font = UIFont(name: "PingFangSC-Medium", size: 15)
               button.tag = type.rawValue
               
               button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
               stackView.addArrangedSubview(button)
               buttons.append(button)
           }
           if let btn = buttons.first {
               btn.isSelected = true
           }
           addSubview(stackView)
       }
    
    // 只负责布局按钮
       private func layoutStackViewAndButtons() {
           guard let stackView = subviews.first as? UIStackView else { return }

           let buttonWidth = 36.0
           let stackViewHeight: CGFloat = frame.height - 3
           let stackViewWidth = frame.width
           stackView.frame = CGRect(x: 0, y: 0, width: stackViewWidth, height: stackViewHeight)

           let totalButtonWidth = CGFloat(titles.count) * buttonWidth
           let totalSpacing = frame.width - totalButtonWidth - stackView.layoutMargins.left - stackView.layoutMargins.right
           stackView.spacing = totalSpacing / CGFloat(titles.count - 1)

           // 计算和设置每个按钮的 frame
           for (index, button) in buttons.enumerated() {
               let buttonX = stackView.layoutMargins.left + CGFloat(index) * (buttonWidth + stackView.spacing)
               button.frame = CGRect(x: buttonX, y: 0, width: buttonWidth, height: stackViewHeight)
           }
       }
    
    // 设置指示器
       private func setupIndicatorView() {
           guard let firstButton = buttons.first else { return }

           indicatorView.backgroundColor = .qc.rgba(55, 66, 250) // 设置指示器颜色
           indicatorView.layer.masksToBounds = true
           indicatorView.layer.cornerRadius = 2
           addSubview(indicatorView)
       }

       // 只负责布局指示器
       private func layoutIndicatorView() {
           guard let firstButton = buttons.first else { return }

           let indicatorHeight: CGFloat = 3
           let indicatorY = frame.height - indicatorHeight - 3
           let indicatorWidth = firstButton.frame.width
           let indicatorX = firstButton.frame.midX - indicatorWidth / 2

           indicatorView.frame = CGRect(x: indicatorX, y: indicatorY, width: indicatorWidth, height: indicatorHeight)
       }

    @objc private func buttonTapped(_ sender: UIButton) {
        
        // 遍历所有按钮，将选中状态设为 false
        for button in buttons {
            button.isSelected = false
        }
        sender.isSelected = true
        updateIndicatorPosition(for: sender)
        
        if let segment = XClipSegmentTap(rawValue: sender.tag) {
            buttonTapHandler?(segment)
        }
    }
       
    private func updateIndicatorPosition(for button: UIButton) {
        let indicatorHeight: CGFloat = 3
        let indicatorY = frame.height - indicatorHeight - 3
        let indicatorWidth = button.frame.width
        let indicatorX = button.frame.midX - indicatorWidth / 2
        
        self.indicatorView.frame = CGRect(x: indicatorX, y: indicatorY, width: indicatorWidth, height: indicatorHeight)
        
    }

}
