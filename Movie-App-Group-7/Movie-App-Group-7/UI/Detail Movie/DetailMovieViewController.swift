//
//  DetailMovieViewController.swift
//  Movie-App-Group-7
//
//  Created by Mohammad Azri on 18/10/22.
//

import UIKit

class DetailMovieViewController: UIViewController {
    public var movieId: String? = nil
    
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieBannerImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieJapaneseTitleLabel: UILabel!
    @IBOutlet private weak var movieDurationLabel: UILabel!
    @IBOutlet private weak var movieYearLabel: UILabel!
    @IBOutlet private weak var movieDirectorLabel: UILabel!
    @IBOutlet private weak var movieDescriptionLabel: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    private let viewModel = DetailMovieViewModel(movieNetworkModel: MovieDefaultNetworkModel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        guard let movieId = movieId else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        configureScrollView()
        retrieveDetailMovie(movieId)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func retrieveDetailMovie(_ movieId: String) {
        
        viewModel.retrieveMovie(movieId: movieId) { [weak self] result in
            switch result {
            case .success(let optionalMovie):
                guard let movie = optionalMovie else {
                    self?.navigationController?.popViewController(animated: true)
                    return
                }
                self?.bindView(movie)
            case .failure(let message):
                print(message)
            }
        }
    }
    
    private func configureScrollView() {
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func bindView(_ movie: Movie) {
        guard let url = URL(string: movie.movieBanner) else { return }
        
        movieImageView.loadFromUrl(url: url)
        movieBannerImageView.loadFromUrl(url: url)
        movieTitleLabel.text = movie.title
        movieJapaneseTitleLabel.text = movie.originalTitle + "(\(movie.originalTitleRomanised))"
        movieDurationLabel.text = movie.duration
        movieYearLabel.text = movie.releaseDate
        movieDirectorLabel.text = "By \(movie.director)"
        movieDescriptionLabel.text = movie.description
    }
}
