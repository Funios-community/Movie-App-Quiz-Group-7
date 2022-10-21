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
    @IBOutlet private weak var movieImageContainerView: UIView!
    @IBOutlet private weak var movieBannerImageView: UIImageView!
    @IBOutlet private weak var movieBannerContainerView: UIView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieJapaneseTitleLabel: UILabel!
    @IBOutlet private weak var movieDurationLabel: UILabel!
    @IBOutlet private weak var movieYearLabel: UILabel!
    @IBOutlet private weak var movieDirectorLabel: UILabel!
    @IBOutlet private weak var movieDescriptionLabel: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var contentView: UIView!
    
    private let viewModel = DetailMovieViewModel(movieNetworkModel: MovieDefaultNetworkModel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        guard let movieId = movieId else {
            self.showError(message: "Movie ID not found", true)
            return
        }
        
        bindObservers()
        viewModel.retrieveMovie(movieId: movieId)
        configureScrollView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func bindObservers() {
        viewModel.movieObservable = { [weak self] movie in
            self?.bindView(movie)
        }
        
        viewModel.showErrorMessage = { [weak self] message in
            if let message = message {
                self?.showError(message: message, true)
            }
        }
        
        viewModel.showLoading = { [weak self] isLoading in
            self?.contentView.isShimmering = isLoading
        }
    }
    
    private func configureScrollView() {
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func bindView(_ movie: Movie) {
        guard let url = URL(string: movie.movieBanner) else { return }
        guard let urlPoster = URL(string: movie.image) else { return }
    
        loadImageUsingKingfisher(url: url, urlPoster: urlPoster)
        movieTitleLabel.text = movie.title
        movieJapaneseTitleLabel.text = movie.originalTitle + "(\(movie.originalTitleRomanised))"
        movieDurationLabel.text = movie.formattedDuration
        movieYearLabel.text = movie.releaseDate
        movieDirectorLabel.text = "By \(movie.director)"
        movieDescriptionLabel.text = movie.description
    }
    
    private func loadImageUsingKingfisher(url: URL, urlPoster: URL) {
        downloadingImage(for: movieImageView, with: url, movieImageContainerView)
        downloadingImage(for: movieBannerImageView, with: urlPoster, movieBannerContainerView)
    }
    
    private func downloadingImage(for imageView: UIImageView, with url: URL, _ view: UIView?) {
        isDownloadingImage(true, view)
        
        imageView.kf.setImage(with: url) { [weak self] result in
            switch result {
            case .success(_):
                self?.isDownloadingImage(false, view)
            case .failure(let error):
                self?.isDownloadingImage(false, view)
                print(error)
            }
        }
    }
    
    private func isDownloadingImage(_ isDownloading: Bool, _ view: UIView?) {
        view?.isShimmering = isDownloading
        view?.backgroundColor = isDownloading ? .gray : .clear
    }
    
    private func showError(message: String? = nil, _ isError: Bool = false) {
        errorLabel.isHidden = !isError
        scrollView.isHidden = isError
        errorLabel.text = message
    }
}
