//
//  MovieTableCell.swift
//  Movie-App-Group-7
//
//  Created by Mac Pro on 26/08/22.
//

import UIKit
import Kingfisher

let stackView = UIStackView()

class MovieTableCell: UITableViewCell {
    @IBOutlet weak var imageMovieBanner: UIImageView!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelOriginalTitle: UILabel!
    @IBOutlet weak var labelSinopsis: UILabel!
    
    @IBOutlet weak var shammering: UIView!
    
    private var downloadTask: URLSessionDataTask?
    private var movie: Movie!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        stackView.spacing = 8.0
    }
    
    func bindData(with movie: Movie) {
        labelMovieTitle.text = movie.title
        labelOriginalTitle.text = movie.orginalTitle
        labelSinopsis.text = movie.description
        
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
            DispatchQueue.main.sync {
                self.shammering.isShimmering = false
                if let data = data {
                    if let image = UIImage(data: data) {
                        self.imageMovieBanner.image = image
                    }
                        //            guard let data = data else { return }
                        //
                        //            if let image = UIImage(data: data) {
                    }
                    
                }
                //            } else {
                //                print("Error fetching image \(String(describing: error))")
                //            }
            }
            self.downloadTask?.resume()
        }
        
    func cancelDownloadAndRemoveImage() {
        downloadTask?.suspend()
        downloadTask = nil
        imageMovieBanner.image = nil
    }
    }
