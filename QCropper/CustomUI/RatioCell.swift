//
//  RatioCell.swift
//  QCropper
//
//  Created by admin on 2024/10/25.
//

import Foundation
import UIKit

class RatioCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 6, y: 10, width: 38, height: 38))
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: bounds.height - 20, width: bounds.width, height: 12))
        label.font = .qc.font(ofSize: 10)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        label.layer.shadowOffset = .zero
        label.layer.shadowOpacity = 1
        return label
    }()
    
    var image: UIImage?
    
    var selectIndex:Int = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let image = image else {
            return
        }
        
        let center = imageView.center
        var w: CGFloat = 36, h: CGFloat = 36

            imageView.layer.cornerRadius = 3
//        }
        imageView.frame = CGRect(x: center.x - w / 2, y: center.y - h / 2, width: w, height: h)
    }
    
    func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    func configureRotateCell(rotate: CropRotateEnum) {
        
        titleLabel.text = rotate.toName()
        titleLabel.textColor = .white
        let imageName = rotate.toImageName()
        image = .qc.getImage(imageName)
        imageView.image = image
        setNeedsLayout()
    }
    
    func configureCell(ratio: CropProportionEnum,select:Bool) {
//        imageView.image = image
        titleLabel.text = ratio.toName()

        if select {
            titleLabel.textColor = .white
            let imageName = "\("QCropper."+ratio.toImageName()+".high")"
            image = .qc.getImage(imageName)
        } else {
            titleLabel.textColor = QCropper.Config.imageEditorToolTitleNormalColor
            let imageName = "\("QCropper."+ratio.toImageName()+".normal")"
            image = .qc.getImage(imageName)
        }
        imageView.image = image
        setNeedsLayout()
    }
}
