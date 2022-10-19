//
//  MovieDetail.swift
//  Movie-App-Group-7
//
//  Created by Nadia Darin on 11/10/22.
//

import Foundation

struct MovieDetail {
    let id: String
    let title: String
    let originalTitle: String
    let originalTitleRomanised: String
    let description: String
    let releaseDate: String
    let director: String
    let movieBanner: String
    let image: String
    let runningTime: String
    
    var formattedDuration: String {
        if let duration = Int(runningTime) {
            return "\(duration / 60)h \(duration % 60)s"
        }
        
        return "\(runningTime)s"
    }
}
