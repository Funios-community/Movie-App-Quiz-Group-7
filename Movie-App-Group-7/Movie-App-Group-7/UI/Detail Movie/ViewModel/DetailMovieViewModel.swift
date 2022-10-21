//
//  DetailMovieViewModel.swift
//  Movie-App-Group-7
//
//  Created by Mohammad Azri on 20/10/22.
//

import Foundation

class DetailMovieViewModel {
    var showLoading: Observer<Bool>?
    var showErrorMessage: Observer<String?>?
    var movieObservable: Observer<Movie>?
    
    private let movieNetworkModel : MovieNetworkModel
    
    init(movieNetworkModel: MovieNetworkModel) {
        self.movieNetworkModel = movieNetworkModel
    }
    
    func retrieveMovie(movieId: String) {
        showLoading?(true)
        showErrorMessage?(nil)
        
        movieNetworkModel.getMovie(movieId: movieId) { [weak self] result in
            switch result {
            case .success(let movie):
                self?.showLoading?(false)
                self?.movieObservable?(movie)
            case .failure(let message):
                self?.showLoading?(false)
                self?.showErrorMessage?(message)
            }
        }
        
    }
}
