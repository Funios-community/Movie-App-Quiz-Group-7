//
//  HomeViewModel.swift
//  Movie-App-Group-7
//
//  Created by Mohammad Azri on 18/10/22.
//

import Foundation

class HomeViewModel {
    var showLoading: Observer<Bool>?
    var showErrorMessage: Observer<String?>?
    var moviesObservable: Observer<[Movie]>?
    
    private var movies = [Movie]()
    private let movieNetworkModel : MovieNetworkModel
    
    init(movieNetworkModel: MovieNetworkModel) {
        self.movieNetworkModel = movieNetworkModel
    }
    
    func retrieveMovies(isRefreshing: Bool = false) {
        showLoading?(isRefreshing)
        showErrorMessage?(nil)
        
        movieNetworkModel.getMovies { [weak self] result in
            switch result {
            case .failure(let message):
                self?.showLoading?(false)
                self?.showErrorMessage?(message)
            case .success(let movies):
                self?.showLoading?(false)
                self?.movies = movies.shuffled()
                self?.moviesObservable?(movies.shuffled())
            }
        }
    }

    func getMovies() -> [Movie] {
        self.movies
    }
}
