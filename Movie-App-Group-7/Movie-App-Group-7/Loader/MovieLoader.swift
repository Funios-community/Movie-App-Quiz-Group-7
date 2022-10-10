//
//  MovieLoader.swift
//  Movie-App-Group-7
//
//  Created by Nadia Darin on 30/09/22.
//

import Foundation

enum MovieResult {
    case success([Movie])
    case failure(String)
}

class MovieLoader {
    
    func getMovieList(completion: @escaping (MovieResult) -> Void) {
        let url = URL(string: "https://ghibliapi.herokuapp.com/films")!
     
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            DispatchQueue.main.sync {
                do {
                    let movies = try self.transformJsonDataToMovieList(with: data!)
                    completion(.success(movies))
                } catch let error {
                    let errorMessage = error.localizedDescription
                    completion(.failure(errorMessage))
                }
            }
        }.resume()
    }
    
    private func transformJsonDataToMovieList(with data: Data) throws -> [Movie] {
        let decoder = JSONDecoder()
        let remoteMovies = try decoder.decode([RemoteMovie].self, from: data)
        let movies = remoteMovies.map { remoteMovie in
            return map(remoteMovie: remoteMovie)
        }
        return movies
    }
    
    private func map(remoteMovie: RemoteMovie) -> Movie {
        return Movie(id: remoteMovie.id, title: remoteMovie.title, orginalTitle: remoteMovie.originalTitle, description: remoteMovie.movieDescription, movieBanner: remoteMovie.movieBanner)
    }
}
