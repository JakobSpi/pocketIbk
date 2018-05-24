//
//  MainTableViewCell.swift
//  pocketIBK
//
//  Created by Jakob on 30.03.18.
//  Copyright © 2018 Jakob. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieInfo: UILabel!
    @IBOutlet weak var cinemaDestAndTime: UILabel!
    var todayProgram: TodayObject? {
        didSet {
            guard let todayProgram = todayProgram else {
                return
            }
            movieImage.image = todayProgram.image
            movieTitle.text = todayProgram.title
            movieGenre.text = todayProgram.genre
            movieInfo.text = todayProgram.info
            cinemaDestAndTime.text = todayProgram.theaterId
        }
    }
}
/*extension UITableViewCell {
    public class func defaultIdentifier() -> String {
        return NSStringFromClass(self)
    }
}*/
