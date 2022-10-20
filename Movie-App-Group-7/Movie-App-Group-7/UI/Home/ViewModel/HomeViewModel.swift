//
//  HomeViewModel.swift
//  Movie-App-Group-7
//
//  Created by Mohammad Azri on 18/10/22.
//

import Foundation

enum RetrievingMoviesState {
    case success
    case failure(String)
}

class HomeViewModel {
    private var movies = [Movie]()
    private let movieNetworkModel : MovieNetworkModel
    
    init(movieNetworkModel: MovieNetworkModel) {
        self.movieNetworkModel = movieNetworkModel
    }
    
    func retrieveMovies(completion: @escaping (RetrievingMoviesState) -> ()) {
        movieNetworkModel.getMovies { result in
            switch result {
            case .failure(let message):
                completion(.failure(message))
            case .success(let movies):
                self.movies = movies
                completion(.success)
            }
        }
    }

    func getMovies() -> [Movie] {
        self.movies
    }
}
