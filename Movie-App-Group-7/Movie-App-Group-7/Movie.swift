//
//  Movie.swift
//  Movie-App-Group-7
//
//  Created by Mac Pro on 26/08/22.
//

import Foundation
import UIKit

struct Movie {
    let id: UUID
    let title: String
    let orginalTitle: String
    let description: String
    let movieBanner: UIImage
    let moviePoster: UIImage
    let director: String
    let duration: Int
    let releaseDate: String
}
