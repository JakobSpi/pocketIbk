//
//  TodayObject.swift
//  pocketIBK
//
//  Created by Jakob Spirk on 23.05.18.
//  Copyright © 2018 Jakob. All rights reserved.
//

import Foundation
import UIKit

struct TodayObject {
    // MARK: - Properties
    let id: String
    let title: String
    let genre: String
    let duration: Int
    let time: Date
    let rating: String
    let theaterId: String
    let theaterName: String
    let info: String
    private(set) var imageUrl: URL?
    var image: UIImage?
    // MARK: - Initialization
    init?(json: [String: Any]) {
        guard
            let id = json["movieId"] as? String,
            let title = json["movieTitle"] as? String,
            let genre = json["movieGenre"] as? String,
            let duration = json["movieDuration"] as? Int,
            let timestamp = json["time"] as? TimeInterval,
            let rating = json["movieRating"] as? String,
            let theaterId = json["theaterId"] as? String,
            let theaterName = json["theaterName"] as? String,
            let info = json["info"] as? String
            else { return nil }
        self.id = id
        self.title = title
        self.duration = duration
        self.time = Date(milliseconds: timestamp)
        self.genre = genre
        self.rating = rating
        self.theaterId = theaterId
        self.theaterName = theaterName
        self.info = info
        if let imageUrlString = json["movieImageUrl"] as? String {
            self.imageUrl = URL(string: imageUrlString)
        }
    }
    mutating func setImage(image: UIImage) {
        self.image = image
    }
}

fileprivate extension Date {
    init(milliseconds: TimeInterval) {
        self.init(timeIntervalSince1970: milliseconds / 1000)
    }
}
