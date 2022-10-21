//
//  MovieLoader.swift
//  Movie-App-Group-7
//
//  Created by Novan Agung Waskito on 08/10/22.
//

import Foundation

enum MovieResult {
    case success ([Movie])
    case failure (String)
}

class MovieLoader {
        //call API dan kenapa menggunakan completion?
    func getMovieListData (completion: @escaping (MovieResult) -> Void) {
        let url = URL(string: "https://ghibliapi.herokuapp.com/films")!
        URLSession.shared.dataTask(with: url){ [weak self] (data, response, error) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                do {
                    let movies = try self.transformJsonDataToMovieList(with: data!)
                    completion (.success(movies))
                } catch let error {
                    let errorMessage = error.localizedDescription
                    completion (.failure(errorMessage))
                }
            }
        }.resume()
    }
    
    func transformJsonDataToMovieList(with data: Data) throws -> [Movie] {
        let decoder = JSONDecoder()
        let movieLists = try decoder.decode([MovieList].self, from: data)
        let movies = movieLists.map { movieList in
            return map(movieList: movieList)
        }
        return movies
    }
    
    private func map(movieList: MovieList) -> Movie {
        return Movie(id: movieList.id, title: movieList.title, orginalTitle: movieList.originalTitle, description: movieList.movieListDescription, movieBanner: movieList.movieBanner)
    }
}
