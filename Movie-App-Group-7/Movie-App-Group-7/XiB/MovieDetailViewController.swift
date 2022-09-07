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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerImageView.image = nil
        posterImageView.image = nil
        titleLabel.text = nil
        originalTitleLabel.text = nil
        durationLabel.text = nil
        releaseDateLabel.text = nil
        directorLabel.text = nil
        descriptionLabel.text = nil
        getMovie()
    }
    
    func getMovie() {
        if let url = URL(string: "https://ghibliapi.herokuapp.com/films/\(movieID!)") {
            URLSession(configuration: .default).dataTask(with: url) { [self] data, urlResponse, error in
                
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let movie = try decoder.decode(Movie.self, from: data)
                        self.downloadImage(url: movie.image, image: self.posterImageView)
                        self.downloadImage(url: movie.movieBanner, image: self.bannerImageView)
                        
                        DispatchQueue.main.async {
                            self.titleLabel.text = movie.title
                            self.originalTitleLabel.text = "\(movie.originalTitle) (\(movie.originalTitleRomanised))"
                            self.releaseDateLabel.text = movie.releaseDate
                            self.descriptionLabel.text = movie.movieDescription
                            self.directorLabel.text = "By \(movie.director)"
                            self.durationLabel.text = movie.formattedDuration
                        }
                        
                    } catch  {
                        debugPrint(error)
                    }
                    
                }
            }.resume()
        }
    }
    
    func downloadImage(url: String , image: UIImageView){
    
        if let imageURL = URL(string: url) {
            let session = URLSession(configuration: .default)
            
            session.dataTask(with: imageURL) { (data, response, error) in
                if let e = error {
                    print("Error downloading cat picture: \(e)")
                } else {
                    if let res = response as? HTTPURLResponse {
                        print("Downloaded cat picture with response code \(res.statusCode)")
                        if let imageData = data {
                            
                            DispatchQueue.main.async {
                                image.image = UIImage(data: imageData)!
                            }
                        } else {
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        print("Couldn't get response code for some reason")
                    }
                }
            }.resume()
        }
        
    }


}
