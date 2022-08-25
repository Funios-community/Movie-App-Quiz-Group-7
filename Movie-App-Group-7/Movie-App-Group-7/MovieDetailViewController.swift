//
//  MovieDetailViewController.swift
//  Movie-App-Group-7
//
//  Created by Nadia Darin on 24/08/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: Movie!

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

        bannerImageView.image = movie.movieBanner
        posterImageView.image = movie.moviePoster
        titleLabel.text = movie.title
        originalTitleLabel.text = movie.orginalTitle
        durationLabel.text = movie.formattedDuration
        releaseDateLabel.text = movie.releaseDate
        descriptionLabel.text = movie.description
        
    }


}
