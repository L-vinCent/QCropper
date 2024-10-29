//
//  Toolbar.swift
//
//  Created by Chen Qizhi on 2019/10/15.
//

import UIKit

class Toolbar: UIView {
    
    var SegTapHandler: ((XClipSegmentTap) -> Void)?

//    lazy var resetButton: UIButton = {
//        let button = self.titleButton("还原", highlight: true)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        button.isHidden = true
//        button.centerX = self.width / 2
//        button.backgroundColor = .qc.rgba(71, 69, 83, 1)
//        button.autoresizingMask = [.flexibleBottomMargin, .flexibleRightMargin]
//        return button
//    }()

    lazy var cancelBtn: EnlargeButton = {
        let btn = EnlargeButton(type: .custom)
        btn.setImage(.qc.getImage("QCropper.crop.close"), for: .normal)
        btn.adjustsImageWhenHighlighted = false
        btn.enlargeInset = 20
        btn.left = 30
        btn.autoresizingMask = [.flexibleBottomMargin, .flexibleRightMargin]

        return btn
    }()
    
    lazy var doneBtn: EnlargeButton = {
        let btn = EnlargeButton(type: .custom)
        btn.setImage(.qc.getImage("QCropper.crop.sure"), for: .normal)
        btn.adjustsImageWhenHighlighted = false
        btn.enlargeInset = 20
        btn.right = -30
        btn.autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin]

        return btn
    }()
    

    lazy var blurBackgroundView: UIVisualEffectView = {
        let vev = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        vev.alpha = 0.3
        vev.backgroundColor = .clear
        vev.frame = self.bounds
        vev.isUserInteractionEnabled = false
        vev.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleHeight, .flexibleWidth]
        return vev
    }()

    //底部segment 布局、滤镜
    private lazy var segmentedControl: CropSegmentView = {
        let titles = ["裁剪","旋转"]
        let control = CropSegmentView(frame: .zero,titles: XClipSegmentTap.allCases) { [weak self] type in
            self?.SegTapHandler?(type)
        }
        control.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleWidth]

        return control
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(blurBackgroundView)
        addSubview(cancelBtn)
//        addSubview(resetButton)
        addSubview(doneBtn)
        addSubview(segmentedControl)
        layoutFrame(frame)
    }

    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func layoutFrame(_ frame: CGRect){
        segmentedControl.frame = CGRect(x: 0, y: 0, width: frame.size.width / 3, height: 44)
        segmentedControl.bottom = frame.height // y 值根据需要设置
        segmentedControl.centerX = frame.width / 2.0
        cancelBtn.frame = CGRect(x: 30, y: 0, width: 25, height: 25)
        doneBtn.frame = CGRect(x: frame.size.width - 30 - 25, y: 0, width: 25, height: 25)
        cancelBtn.centerY = segmentedControl.centerY
        doneBtn.centerY = segmentedControl.centerY
    }
}
