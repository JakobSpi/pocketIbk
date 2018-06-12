//
//  MovieObject.swift
//  pocketIBK
//
//  Created by Jakob Spirk on 02.06.18.
//  Copyright © 2018 Jakob. All rights reserved.
//

import Foundation

import UIKit

struct MovieObject {
    // MARK: - Properties
    let id: String
    let title: String
    let description: String
    let land: String
    let age: String
    let year: String
    let genre: String
    let duration: Int
    let rating: String
    let director: String
    let actors: String
    private(set) var imageUrl: URL?
    private(set) var trailerUrl: URL?
    private(set) var wikiUrl: URL?
    private(set) var imdbUrl: URL?
    var image: UIImage?
    // MARK: - Initialization
    init?(json: [String: Any]) {
        guard
            let id = json["id"] as? String,
            let title = json["title"] as? String,
            let genre = json["genre"] as? String,
            let duration = json["duration"] as? Int,
            let rating = json["rating"] as? String,
            let description = json["description"] as? String,
            let land = json["land"] as? String,
            let age = json["age"] as? String,
            let year = json["year"] as? String,
            let director = json["director"] as? String,
            let actors = json["actors"] as? String
            else { return nil }
        self.id = id
        self.title = title
        self.description = description
        self.land = land
        self.age = age
        self.year = year
        self.genre = genre
        self.duration = duration
        self.rating = rating
        self.director = director
        self.actors = actors
        if let imageUrlString = json["imageUrl"] as? String {
            self.imageUrl = URL(string: imageUrlString)
        }
        if let trailerUrlString = json["trailerUrl"] as? String {
            self.trailerUrl = URL(string: trailerUrlString)
        }
        if let wikiUrlString = json["wikiUrl"] as? String {
            self.wikiUrl = URL(string: wikiUrlString)
        }
        if let imdbUrlString = json["imdbUrl"] as? String {
            self.imdbUrl = URL(string: imdbUrlString)
        }
    }
    mutating func setImage(image: UIImage) {
        self.image = image
    }
}
