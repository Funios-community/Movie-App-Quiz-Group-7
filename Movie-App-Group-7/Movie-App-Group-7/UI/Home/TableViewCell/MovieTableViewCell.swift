//
//  MovieTableViewCell.swift
//  Movie-App-Group-7
//
//  Created by Mohammad Azri on 18/10/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieSubtitleLabel: UILabel!
    @IBOutlet private weak var movieDescriptionLabel: UILabel!
    
    func bind(_ movie: Movie) {
        guard let url = URL(string: movie.movieBanner) else { return }
        movieImageView.loadFromUrl(url: url)
        movieTitleLabel.text = movie.title
        movieSubtitleLabel.text = movie.originalTitle + "(\(movie.originalTitleRomanised))"
        movieDescriptionLabel.text = movie.description
    }
}
