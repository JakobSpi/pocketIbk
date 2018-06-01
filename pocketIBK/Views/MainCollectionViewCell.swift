//
//  MainCollectionViewCell.swift
//  pocketIBK
//
//  Created by Jakob Spirk on 26.05.18.
//  Copyright © 2018 Jakob. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieInfo: UILabel!
    @IBOutlet weak var cinemaDestAndTime: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    var todayProgram: TodayObject? {
        didSet {
            guard let todayProgram = todayProgram else {
                return
            }
            movieImage.image = todayProgram.image
            movieTitle.text = todayProgram.title
            movieGenre.text = todayProgram.genre
            movieInfo.text = todayProgram.info
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            cinemaDestAndTime.text = todayProgram.theaterName + " - " + dateFormatter.string(from: todayProgram.time)
        }
    }
}
