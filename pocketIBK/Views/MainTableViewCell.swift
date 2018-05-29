//
//  MainTableViewCell.swift
//  pocketIBK
//
//  Created by Jakob on 30.03.18.
//  Copyright © 2018 Jakob. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var mainCollectionView: UICollectionView!
    func setCollectionViewDelegate<D: UICollectionViewDelegate, E: UICollectionViewDataSource>
        (dataSource: D, delegate: E, forRow row: Int) {
        mainCollectionView.delegate = dataSource
        mainCollectionView.dataSource = delegate
        mainCollectionView.tag = row + 1
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        mainCollectionView.setCollectionViewLayout(layout, animated: true)
        mainCollectionView.reloadData()
    }
}
/*extension UITableViewCell {
    public class func defaultIdentifier() -> String {
        return NSStringFromClass(self)
    }
}*/
