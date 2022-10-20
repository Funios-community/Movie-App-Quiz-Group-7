//
//  DetailMovieViewModel.swift
//  Movie-App-Group-7
//
//  Created by Mohammad Azri on 20/10/22.
//

import Foundation

enum RetrievingDetailMovieState {
    case success(Movie?)
    case failure(String)
}

class DetailMovieViewModel {
    private let movieNetworkModel : MovieNetworkModel
    
    init(movieNetworkModel: MovieNetworkModel) {
        self.movieNetworkModel = movieNetworkModel
    }
    
    func retrieveMovie(movieId: String, completion : @escaping (RetrievingDetailMovieState) -> ()) {
        movieNetworkModel.getMovie(movieId: movieId) { result in
            switch result {
            case .success(let movie):
                completion(.success(movie))
            case .failure(let message):
                completion(.failure(message))
            }
        }
        
    }
}
