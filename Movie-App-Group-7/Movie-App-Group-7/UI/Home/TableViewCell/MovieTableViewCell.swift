//
//  MovieTableViewCell.swift
//  Movie-App-Group-7
//
//  Created by Mohammad Azri on 18/10/22.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    @IBOutlet private weak var containerImageView: UIView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieSubtitleLabel: UILabel!
    @IBOutlet private weak var movieDescriptionLabel: UILabel!
    
    func bind(_ movie: Movie) {
        guard let url = URL(string: movie.movieBanner) else { return }
        loadImageUsingKingfisher(url: url)
        movieTitleLabel.text = movie.title
        movieSubtitleLabel.text = movie.originalTitle + "(\(movie.originalTitleRomanised))"
        movieDescriptionLabel.text = movie.description
    }
    
    func loadImageUsingKingfisher(url: URL) {
        isDownloadingImage(true)
        movieImageView.kf.setImage(with: url) { [weak self] result in
            switch result {
            case .success(_):
                self?.isDownloadingImage(false)
            case .failure(_):
                self?.isDownloadingImage(false)
            }
        }
    }
    
    func cancelDownloadingImage() {
        isDownloadingImage(false)
        movieImageView.kf.cancelDownloadTask()
        movieImageView.image = nil
    }
    
    private func isDownloadingImage(_ isDownloading: Bool) {
        containerImageView.isShimmering = isDownloading
        containerImageView.backgroundColor = isDownloading ? .gray : .clear
    }
}
