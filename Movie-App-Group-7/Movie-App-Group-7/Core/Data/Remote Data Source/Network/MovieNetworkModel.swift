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
    case success(Movie?)
    case failure(String)
}

protocol MovieNetworkModel {
    func getMovies(completion: @escaping (MovieNetworkResult) -> ())
    func getMovie(movieId: String, completion: @escaping (DetailMovieNetworkResult) -> ())
}

final class MovieDefaultNetworkModel : MovieNetworkModel {
    func getMovies(completion: @escaping (MovieNetworkResult) -> ()) {
        guard let url = URL(string: "https://ghibliapi.herokuapp.com/films") else {
            DispatchQueue.main.async {
                completion(.failure("Bad URL"))
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.global(qos: .background).async {
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }

                do {
                    let result = try JSONDecoder().decode([MovieResponse].self, from: data)
                    let response = ObjectMapper().mapMoviesResponseToMoviesDomain(moviesResponse: result)
                    DispatchQueue.main.async {
                        completion(.success(response))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure("Failed to convert"))
                    }
                }
            }
        }.resume()
    }
    
    func getMovie(movieId: String, completion: @escaping (DetailMovieNetworkResult) -> ()) {
        guard let url = URL(string: "https://ghibliapi.herokuapp.com/films/\(movieId)") else {
            DispatchQueue.main.async {
                completion(.failure("Bad URL"))
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.global(qos: .background).async {
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(.success(nil))
                    }
                    return
                }

                do {
                    let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                    let response = ObjectMapper().mapMovieResponseToMovieDomain(movieResponse: result)
                    DispatchQueue.main.async {
                        completion(.success(response))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure("Failed to convert"))
                    }
                }
            }
        }.resume()
    }
}
