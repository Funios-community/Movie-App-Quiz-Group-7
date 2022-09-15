//
//  MovieDetails.swift
//  Movie-App-Group-7
//
//  Created by Nadia Darin on 13/09/22.
//

import Foundation
import UIKit

struct MovieDetails: Codable {
    let id, title, originalTitle, originalTitleRomanised: String
    let image, movieBanner: String
    let movieDescription, director, producer, releaseDate: String
    let runningTime, rtScore: String
    let people, species, locations, vehicles: [String]
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case originalTitle = "original_title"
        case originalTitleRomanised = "original_title_romanised"
        case image
        case movieBanner = "movie_banner"
        case movieDescription = "description"
        case director, producer
        case releaseDate = "release_date"
        case runningTime = "running_time"
        case rtScore = "rt_score"
        case people, species, locations, vehicles, url
    }
    
    var formattedDuration: String {
        if let duration = Int(runningTime) {
            return "\(duration / 60)h \(duration % 60)s"
        }
        
        return "\(runningTime)s"
    }
}
