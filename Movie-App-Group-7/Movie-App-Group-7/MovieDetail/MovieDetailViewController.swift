//
//  MovieDetailViewController.swift
//  Movie-App-Group-7
//
//  Created by Nadia Darin on 24/08/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movieID: String!
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var posterContainer: UIView!
    @IBOutlet weak var bannerContainer: UIView!
    @IBOutlet weak var posterReloadButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var bannerButton: UIButton!
     
    private var posterImageURL: String?
    private var bannerImageURL: String?
    
    var loader = MovieDetailLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetDetails()
        getMovie()
    }
    
    @IBAction func posterReloadButtonPressed(_ sender: UIButton) {
        self.downloadImage(url: posterImageURL!, image: posterImageView, imageContainer: posterContainer, reloadButton: posterReloadButton)
    }
    
    @IBAction func bannerButtonPressed(_ sender: UIButton) {
        self.downloadImage(url: bannerImageURL!, image: bannerImageView, imageContainer: bannerContainer, reloadButton: bannerButton)
    }
    
    func getMovie() {
        if let movieID = movieID {
            loadingIndicator.isHidden = false
            loader.getMovieList(movieID: movieID) { result in
                switch result {
                case .success(let movie):
                    self.downloadAndBindImage(with: movie)
                    self.bindData(with: movie)
                    
                case .failure(let e):
                    print("Error: \(e)")
                }
            }
        }
        
    }
    
    private func downloadAndBindImage(with movie: MovieDetail){
        posterImageURL = movie.image
        bannerImageURL = movie.movieBanner
        
        // for poster image
        self.downloadImage(url: movie.image, image: self.posterImageView, imageContainer: self.posterContainer, reloadButton: self.posterReloadButton)
        
        // for banner image
        self.downloadImage(url: movie.movieBanner, image: self.bannerImageView, imageContainer: self.bannerContainer, reloadButton: self.bannerButton)
        
    }
    
    private func downloadImage(url: String , image: UIImageView, imageContainer: UIView, reloadButton: UIButton){
        startLoadingImageContainer(for: imageContainer)
        let loader = ImageLoader()
        
        loader.downloadImageWithURLSession(url: url) { result in
            switch result {
            case .success(let downloadedImage):
                self.stopLoadingImageContainer(for: imageContainer)
                image.image = downloadedImage
            case .failure(_):
                self.showErrorforImage(container: imageContainer, errorButton: reloadButton)
            }
        }
    }
    
    private func bindData(with movie: MovieDetail){
        self.titleLabel.text = movie.title
        self.originalTitleLabel.text = "\(movie.originalTitle) (\(movie.originalTitleRomanised))"
        self.releaseDateLabel.text = movie.releaseDate
        self.descriptionLabel.text = movie.description
        self.directorLabel.text = "By \(movie.director)"
        self.durationLabel.text = movie.formattedDuration
        self.loadingIndicator.isHidden = true
    }
    
    private func showErrorforImage(container: UIView, errorButton: UIButton){
        DispatchQueue.main.sync {
            container.isShimmering = false
            errorButton.isHidden = false
        }
    }
    
    private func startLoadingImageContainer(for imageContainer: UIView){
        DispatchQueue.main.async {
            imageContainer.isShimmering = true
            imageContainer.backgroundColor = .gray
        }
    }
    
    private func stopLoadingImageContainer(for imageContainer: UIView){
        imageContainer.isShimmering = false
        imageContainer.backgroundColor = .clear
    }
    
    private func resetDetails() {
        bannerImageView.image = nil
        posterImageView.image = nil
        titleLabel.text = nil
        originalTitleLabel.text = nil
        durationLabel.text = nil
        releaseDateLabel.text = nil
        directorLabel.text = nil
        descriptionLabel.text = nil
        posterReloadButton.isHidden = true
        bannerButton.isHidden = true
        loadingIndicator.isHidden = true
    }
    
}
