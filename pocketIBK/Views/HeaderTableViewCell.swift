//
//  HeaderTableViewCell.swift
//  pocketIBK
//
//  Created by Jakob Spirk on 28.05.18.
//  Copyright © 2018 Jakob. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    var headerModel: HeaderTableViewModel? {
        didSet {
            guard let headerModel = headerModel else {
                return
            }
            headerImage.image = headerModel.image
            headerLabel.text = headerModel.labelText
        }
    }
}
