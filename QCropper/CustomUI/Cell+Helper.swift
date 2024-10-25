//
//  Cell+Helper.swift
//  QCropper
//
//  Created by admin on 2024/10/25.
//

import Foundation

extension QCropWrapper where Base: UICollectionViewCell {
    static var identifier: String {
        NSStringFromClass(Base.self)
    }
    
    static func register(_ collectionView: UICollectionView) {
        collectionView.register(Base.self, forCellWithReuseIdentifier: identifier)
    }
}

extension QCropWrapper where Base: UITableViewCell {
    static var identifier: String {
        NSStringFromClass(Base.self)
    }
    
    static func register(_ tableView: UITableView) {
        tableView.register(Base.self, forCellReuseIdentifier: identifier)
    }
}
