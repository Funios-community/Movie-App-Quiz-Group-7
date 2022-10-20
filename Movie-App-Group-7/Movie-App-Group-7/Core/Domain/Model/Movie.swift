//
//  Movie.swift
//  Movie-App-Group-7
//
//  Created by Mohammad Azri on 18/10/22.
//

import Foundation

struct Movie {
    let id: String
    let title: String
    let originalTitle: String
    let originalTitleRomanised: String
    let description: String
    let image: String
    let movieBanner: String
    let director: String
    let duration: String
    let releaseDate: String
    
    var formattedDuration : String {
        guard let duration = Int(duration) else { return duration }
        return "\(duration/60)h \(duration%60)s"
    }
}
