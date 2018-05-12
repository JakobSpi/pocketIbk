//
//  todayObject.swift
//  pocketIBK
//
//  Created by Jakob on 16.02.18.
//  Copyright © 2018 Jakob. All rights reserved.
//

import Foundation
import UIKit

struct TodayObject {
    let theaterId: String
    let theaterName: String
    let movieId: String
    let movieTitle: String
    let movieGenre: String
    let movieRating: String
    var movieImage: UIImage?
    let movieDuration: Int
    let time: Date?
    let info: String
    init(theaterId: String, theaterName: String, movieId: String,
         movieTitle: String, movieGenre: String, movieRating: String, movieInfo: String) {
        self.theaterId = theaterId
        self.theaterName = theaterName
        self.movieId = movieId
        self.movieTitle = movieTitle
        self.movieGenre = movieGenre
        self.movieRating = movieRating
        self.movieImage = nil
        self.movieDuration = -1
        self.time = nil
        self.info = movieInfo
    }
}
