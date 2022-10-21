//
//  kfMovieList.swift
//  Movie-App-Group-7
//
//  Created by Novan Agung Waskito on 07/09/22.
//

import Foundation
import Kingfisher
import UIKit


struct MovieList: Codable {
    let id : String
    let title: String
    let originalTitle: String
    let originalTitleRomanised: String
    let image: URL
    let movieBanner: URL
    let movieListDescription: String
    let director: String
    let producer: String
    let releaseDate: String
    let runningTime: String
    let rtScore: String
    let people: [String]
    let species: [String]
    let locations: [String]
    let vehicles: [String]
    let url: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case originalTitle = "original_title"
        case originalTitleRomanised = "original_title_romanised"
        case image
        case movieBanner = "movie_banner"
        case movieListDescription = "description"
        case director, producer
        case releaseDate = "release_date"
        case runningTime = "running_time"
        case rtScore = "rt_score"
        case people, species, locations, vehicles, url
    }
    
}
