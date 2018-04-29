//
//  TodayJSONObject.swift
//  pocketIBK
//
//  Created by Jakob on 15.02.18.
//  Copyright © 2018 Jakob. All rights reserved.
//

import Foundation

struct TodayJSONObject:Decodable{
    
    
    var theaterId: String
    var theaterName: String
    var movieId: String
    var movieTitle: String
    var movieGenre: String
    var movieRating: String
    var movieImageUrl: String
    var movieDuration: Int
    var time: Int
    var info: String
     
}
