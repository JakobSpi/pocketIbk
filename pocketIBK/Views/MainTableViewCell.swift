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
        mainCollectionView.reloadData()
    }
}
/*extension UITableViewCell {
    public class func defaultIdentifier() -> String {
        return NSStringFromClass(self)
    }
}*/
