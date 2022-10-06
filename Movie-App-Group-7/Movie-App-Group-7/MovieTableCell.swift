//
//  MovieTableCell.swift
//  Movie-App-Group-7
//
//  Created by Mac Pro on 26/08/22.
//

import UIKit
import Kingfisher

class MovieTableCell: UITableViewCell {
    @IBOutlet weak var imageMovieBanner: UIImageView!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelOriginalTitle: UILabel!
    @IBOutlet weak var labelSinopsis: UILabel!
    
    @IBOutlet weak var shammering: UIView!
    
    private var downloadTask: URLSessionDataTask?
    private var movie: APIGhibli!

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func bindData(with movie: Movie) {
        imageMovieBanner.image = movie.movieBanner
        labelMovieTitle.text = movie.title
        labelOriginalTitle.text = movie.orginalTitle
        labelSinopsis.text = movie.description
    }
    
    func bindData(with movie: APIGhibli) {
        labelMovieTitle.text = movie.title
        labelOriginalTitle.text = movie.originalTitle
        labelSinopsis.text = movie.remoteMovieDescription
        
        self.movie = movie
    }
    
    func downloadImageKingfisher() {
        imageMovieBanner.kf.setImage(with: self.movie.movieBanner)
    }
    
    func cancelDownloadImageKingfisher() {
        imageMovieBanner.kf.cancelDownloadTask()
        imageMovieBanner.image = nil
    }
    
    func downloadImage() {
        shammering.isShimmering = true
        downloadTask = URLSession.shared.dataTask(with: self.movie.movieBanner) { data, response, error in
            guard let data = data else { return }
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.sync {
                    self.shammering.isShimmering = false
                    self.imageMovieBanner.image = image
                }
            } else {
                print("Error fetching image \(error)")
            }
        }
        downloadTask?.resume()
    }
    
    func cancelDownloadRemoveImage() {
        downloadTask?.suspend()
        downloadTask = nil
        imageMovieBanner.image = nil
    }
}
