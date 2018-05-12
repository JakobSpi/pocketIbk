//
//  TodayJSONObject.swift
//  pocketIBK
//
//  Created by Jakob on 15.02.18.
//  Copyright © 2018 Jakob. All rights reserved.
//

import Foundation

struct TodayJSONObject: Decodable {
    let theaterId: String
    let theaterName: String
    let movieId: String
    let movieTitle: String
    let movieGenre: String
    let movieRating: String
    let movieImageUrl: String
    let movieDuration: Int
    let time: Int
    let info: String
}
