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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetDetails()
        getMovie()
    }
    
    func getMovie() {
        loadingIndicator.isHidden = false
        if let url = URL(string: "https://ghibliapi.herokuapp.com/films/\(movieID!)") {
            URLSession(configuration: .default).dataTask(with: url) { [self] data, urlResponse, error in
                
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let movie = try decoder.decode(MovieDetails.self, from: data)
                        posterImageURL = movie.image
                        bannerImageURL = movie.movieBanner
                        self.downloadImage(url: movie.image, image: self.posterImageView, imageContainer: self.posterContainer, reloadButton: self.posterReloadButton)
                        self.downloadImage(url: movie.movieBanner, image: self.bannerImageView, imageContainer: self.bannerContainer, reloadButton: self.bannerButton)
                        
                        DispatchQueue.main.async {
                            self.titleLabel.text = movie.title
                            self.originalTitleLabel.text = "\(movie.originalTitle) (\(movie.originalTitleRomanised))"
                            self.releaseDateLabel.text = movie.releaseDate
                            self.descriptionLabel.text = movie.movieDescription
                            self.directorLabel.text = "By \(movie.director)"
                            self.durationLabel.text = movie.formattedDuration
                            self.loadingIndicator.isHidden = true
                        }
                        
                    } catch  {
                        debugPrint(error)
                    }
                    
                }
            }.resume()
        }
    }
    
    func downloadImage(url: String , image: UIImageView, imageContainer: UIView, reloadButton: UIButton){
        DispatchQueue.main.async {
            imageContainer.isShimmering = true
            imageContainer.backgroundColor = .gray
            
        }
        
        
        if let imageURL = URL(string: url) {
            let session = URLSession(configuration: .default)
            
            session.dataTask(with: imageURL) { (data, response, error) in
                if let _ = error {
                    self.showErrorforImage(container: imageContainer, errorButton: reloadButton)
                } else {
                    if let _ = response as? HTTPURLResponse {
                  
                        if let imageData = data {
                            
                            DispatchQueue.main.sync {
                                imageContainer.isShimmering = false
                                imageContainer.backgroundColor = .clear
                                image.image = UIImage(data: imageData)!
                            }
                        } else {
                            self.showErrorforImage(container: imageContainer, errorButton: reloadButton)
                        }
                    } else {
                        self.showErrorforImage(container: imageContainer, errorButton: reloadButton)
                    }
                }
            }.resume()
        } else {
            self.showErrorforImage(container: imageContainer, errorButton: reloadButton)
        }
        
    }
    
    func showErrorforImage(container: UIView, errorButton: UIButton){
        DispatchQueue.main.sync {
            container.isShimmering = false
            errorButton.isHidden = false
        }
        
    }
    
    @IBAction func posterReloadButtonPressed(_ sender: UIButton) {
        self.downloadImage(url: posterImageURL!, image: posterImageView, imageContainer: posterContainer, reloadButton: posterReloadButton)
    }
    
    @IBAction func bannerButtonPressed(_ sender: UIButton) {
                self.downloadImage(url: bannerImageURL!, image: bannerImageView, imageContainer: bannerContainer, reloadButton: bannerButton)
    }
    
    
    func resetDetails() {
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
