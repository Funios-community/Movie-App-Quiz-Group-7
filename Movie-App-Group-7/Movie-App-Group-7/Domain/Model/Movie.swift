//
//  Movie.swift
//  Movie-App-Group-7
//
//  Created by Mohammad Azri on 18/10/22.
//

import Foundation

struct Movie : Codable {
    let id: String
    let title: String
    let originalTitle: String
    let originalTitleRomanised: String
    let description: String
    let movieBanner: String
    let director: String
    let duration: String
    let releaseDate: String
    
    enum CodingKeys : String, CodingKey {
        case id, title, description, director
        case originalTitle = "original_title"
        case originalTitleRomanised = "original_title_romanised"
        case movieBanner = "movie_banner"
        case duration = "running_time"
        case releaseDate = "release_date"
    }
}
