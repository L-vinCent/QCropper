//
//  CropRatioCollectionView.swift
//  QCropper
//
//  Created by admin on 2024/10/25.
//

import Foundation

class CropRatioCollectionView: UIView {
    
    static let Ratioheight = 70.0
    private var currentClipSegment:XClipSegmentTap = .clip{
        didSet{
            let isClip = currentClipSegment == .clip ? true : false
            clipRatioColView.isHidden = !isClip
            rotateColView.isHidden = isClip
        }
    }
    var clipRatios :[XCropProportionEnum] = XCropProportionEnum.allCases
    private var clipRotates :[XCropRotateEnum] = XCropRotateEnum.allCases
    private var selectedRatio: XCropProportionEnum = .custom(size: .zero)

    private lazy var clipRatioColView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 48, height: 70)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 30)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .black
        view.isHidden = clipRatios.count <= 1
        view.showsHorizontalScrollIndicator = false
        view.isHidden = true
        RatioCell.qc.register(view)
        return view
    }()
    
    private lazy var rotateColView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 48, height: 70)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        layout.scrollDirection = .horizontal
        
        let width = (self.width - 60 - (48 * 4)) / 3
        layout.minimumLineSpacing = width
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .black
        view.isHidden = true

        view.showsHorizontalScrollIndicator = false
        view.isHidden = true
        RatioCell.qc.register(view)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(clipRatioColView)
        addSubview(rotateColView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        clipRatioColView.frame = self.bounds
        rotateColView.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handSegmentTap(type:XClipSegmentTap){
        currentClipSegment = type
    }
}

//MARK: UICollectionViewDataSource 、UICollectionViewDelegate
extension CropRatioCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == clipRatioColView){
            return clipRatios.count
        }else{
            return clipRotates.count
        }
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RatioCell.qc.identifier, for: indexPath) as! RatioCell
        
        if (collectionView == clipRatioColView){
            let ratio = clipRatios[indexPath.row]
            let selectIndex = clipRatios.firstIndex(of: selectedRatio) ?? 0
            cell.configureCell(ratio: ratio,select: selectIndex == indexPath.row)
            
        }else{
            let ratio = clipRotates[indexPath.row]
            cell.configureRotateCell(rotate: ratio)
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView == clipRatioColView){
            let ratio = clipRatios[indexPath.row]
            guard ratio != selectedRatio else {
                return
            }
//            UClick(param: ratio.UMClickName)
            selectedRatio = ratio
            clipRatioColView.reloadData()
            clipRatioColView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//            calculateClipRect()
//            let rect = calculChangeScale()
//            changeClipBoxFrame(newFrame: rect,animation: true)
            
        }else{
            let rotate = clipRotates[indexPath.row]
//            rotateClick(type: rotate)
        }
    }
}
