//
//  MovieNetworkModel.swift
//  Movie-App-Group-7
//
//  Created by Mohammad Azri on 20/10/22.
//

import Foundation

enum MovieNetworkResult {
    case success([Movie])
    case failure(String)
}

enum DetailMovieNetworkResult {
    case success(Movie)
    case failure(String)
}

protocol MovieNetworkModel {
    func getMovies(completion: @escaping (MovieNetworkResult) -> ())
    func getMovie(movieId: String, completion: @escaping (DetailMovieNetworkResult) -> ())
}

final class MovieDefaultNetworkModel : MovieNetworkModel {
    func getMovies(completion: @escaping (MovieNetworkResult) -> ()) {
        let url = URL(string: "https://ghibliapi.herokuapp.com/films")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    completion(.failure("Data not found"))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode([MovieResponse].self, from: data)
                    let response = ObjectMapper().mapMoviesResponseToMoviesDomain(moviesResponse: result)
                    completion(.success(response))
                } catch {
                    completion(.failure("Failed to convert"))
                }
            }
            
            
        }.resume()
    }
    
    func getMovie(movieId: String, completion: @escaping (DetailMovieNetworkResult) -> ()) {
        let url = URL(string: "https://ghibliapi.herokuapp.com/films/\(movieId)")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    completion(.failure("Data not found"))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                    let response = ObjectMapper().mapMovieResponseToMovieDomain(movieResponse: result)
                    completion(.success(response))
                } catch {
                    completion(.failure("Failed to convert"))
                }
            }
        }.resume()
    }
}
