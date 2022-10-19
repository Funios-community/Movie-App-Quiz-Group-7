//
//  MovieDetailLoader.swift
//  Movie-App-Group-7
//
//  Created by Nadia Darin on 11/10/22.
//

import Foundation

enum MovieDetailResult {
    case success(MovieDetail)
    case failure(String)
}

class MovieDetailLoader {
    
    func getMovieList(movieID: String, completion: @escaping (MovieDetailResult) -> Void) {
        let url = URL(string: "https://ghibliapi.herokuapp.com/films/\(movieID)")!
     
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            DispatchQueue.main.sync {
                do {
                    let movie = try self.transformJsonDataToMovieList(with: data!)
                    completion(.success(movie))
                } catch let error {
                    let errorMessage = error.localizedDescription
                    completion(.failure(errorMessage))
                }
            }
        }.resume()
    }
    
    private func transformJsonDataToMovieList(with data: Data) throws -> MovieDetail {
        let decoder = JSONDecoder()
        let remoteMovie = try decoder.decode(RemoteMovieDetails.self, from: data)
        let movie = map(remoteMovie: remoteMovie)
        return movie
    }
    
    private func map(remoteMovie: RemoteMovieDetails) -> MovieDetail {
        return MovieDetail(
            id: remoteMovie.id,
            title: remoteMovie.title,
            originalTitle: remoteMovie.originalTitle,
            originalTitleRomanised: remoteMovie.originalTitleRomanised,
            description: remoteMovie.movieDescription,
            releaseDate: remoteMovie.releaseDate,
            director: remoteMovie.director,
            movieBanner: remoteMovie.movieBanner,
            image: remoteMovie.image,
            runningTime: remoteMovie.runningTime
        )
    }
}
