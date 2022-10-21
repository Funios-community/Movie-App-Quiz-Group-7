//
//  ObjectMapper.swift
//  Movie-App-Group-7
//
//  Created by Mohammad Azri on 20/10/22.
//

import Foundation
import SwiftUI

class ObjectMapper {
    func mapMoviesResponseToMoviesDomain(moviesResponse: [MovieResponse]) -> [Movie] {
        moviesResponse.map { movieResponse in
            Movie(
                id: movieResponse.id,
                title: movieResponse.title,
                originalTitle: movieResponse.originalTitle,
                originalTitleRomanised: movieResponse.originalTitleRomanised,
                description: movieResponse.description,
                image: movieResponse.image,
                movieBanner: movieResponse.movieBanner,
                director: movieResponse.director,
                duration: movieResponse.duration,
                releaseDate: movieResponse.releaseDate
            )
        }
    }
    
    func mapMovieResponseToMovieDomain(movieResponse: MovieResponse) -> Movie {
        Movie(
            id: movieResponse.id,
            title: movieResponse.title,
            originalTitle: movieResponse.originalTitle,
            originalTitleRomanised: movieResponse.originalTitleRomanised,
            description: movieResponse.description,
            image: movieResponse.image,
            movieBanner: movieResponse.movieBanner,
            director: movieResponse.director,
            duration: movieResponse.duration,
            releaseDate: movieResponse.releaseDate
        )
    }
}
