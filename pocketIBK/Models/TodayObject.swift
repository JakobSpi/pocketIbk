//
//  todayObject.swift
//  pocketIBK
//
//  Created by Jakob on 16.02.18.
//  Copyright © 2018 Jakob. All rights reserved.
//

import Foundation
import UIKit

struct TodayObject{
    
    var theaterId: String
    var theaterName: String
    var movieId: String
    var movieTitle: String
    var movieGenre: String
    var movieRating: String
    var movieImage: UIImage?
    var movieDuration: Int
    var time: Date?
    var info: String
    
    init(_theaterId: String, _theaterName: String, _movieId: String, _movieTitle: String, _movieGenre: String, _movieRating: String, _movieImage: UIImage, _movieDuration: Int, _time: Date, _info: String) {
        self.theaterId = _theaterId
        self.theaterName = _theaterName
        self.movieId = _movieId
        self.movieTitle = _movieTitle
        self.movieGenre = _movieGenre
        self.movieRating = _movieRating
        self.movieImage = _movieImage
        self.movieDuration = _movieDuration
        self.time = _time
        self.info = _info
    }
    init(_theaterId: String, _theaterName: String, _movieId: String, _movieTitle: String, _movieGenre: String, _movieRating: String, _movieInfo: String) {
        self.theaterId = _theaterId
        self.theaterName = _theaterName
        self.movieId = _movieId
        self.movieTitle = _movieTitle
        self.movieGenre = _movieGenre
        self.movieRating = _movieRating
        self.movieImage = nil
        self.movieDuration = -1
        self.time = nil
        self.info = _movieInfo
    }
    
}
