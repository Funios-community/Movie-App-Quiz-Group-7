//
//  APIGhibliDetail.swift
//  Movie-App-Group-7
//
//  Created by Mac Pro on 14/10/22.
//

import Foundation

struct APIGhibliDetail: Decodable {
    let id, title, originalTitle, originalTitleRomanised: String
    let image, movieBanner: URL
    let remoteMovieDescription, director, producer, releaseDate: String
    let runningTime, rtScore: String
    let people, species, locations, vehicles: [String]
    let url: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case originalTitle = "original_title"
        case originalTitleRomanised = "original_title_romanised"
        case image
        case movieBanner = "movie_banner"
        case remoteMovieDescription = "description"
        case director, producer
        case releaseDate = "release_date"
        case runningTime = "running_time"
        case rtScore = "rt_score"
        case people, species, locations, vehicles, url
    }
}
