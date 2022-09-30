//
//  MovieTableViewCell.swift
//  Movie-App-Group-7
//
//  Created by Nadia Darin on 24/08/22.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleOriginalLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var errorDescriptionLabel: UILabel!
    @IBOutlet weak var errorButton: UIButton!
    
    private var downloadTask: URLSessionDataTask?
    private var movieImageURL: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        selectionStyle = .none
        resetCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpData(movie: RemoteMovie) {
        titleLabel.text = movie.title
        titleOriginalLabel.text = "\(movie.originalTitle) (\(movie.originalTitleRomanised))"
        descriptionLabel.text = movie.movieDescription
        movieImageURL = movie.movieBanner
//        if let bannerURL = URL(string: movie.movieBanner) {
//            movieImageView.kf.setImage(with: bannerURL)
//        }
    }
    
    func downloadImage(imageURL: String) {
        imageContainerView.isShimmering = true
        imageContainerView.backgroundColor = .gray
        
        if let movieURL = URL(string: imageURL) {
            self.downloadTask = URLSession.shared.dataTask(with: movieURL) { data, response, error in
                DispatchQueue.main.sync {
                    
                    if let data = data {
                        if let image = UIImage(data: data) {
                            self.imageContainerView.isShimmering = false
                            self.imageContainerView.backgroundColor = .clear
                            self.movieImageView.image = image
                            self.errorDescriptionLabel.isHidden = true
                            self.errorButton.isHidden = true
                            
                        }
                    } else {
                        self.showErrorforImage()
                    }
                }
            }
            self.downloadTask?.resume()
        } else {
            showErrorforImage()
        }
        
        
    }
    
    func cancelDownloadAndRemoveImage() {
        downloadTask?.suspend()
        downloadTask = nil
        movieImageView.image = nil
    }
    
    func showErrorforImage(){
        imageContainerView.isShimmering = false
        errorDescriptionLabel.isHidden = false
        errorButton.isHidden = false
    }
    
    @IBAction func errorButtonPressed(_ sender: UIButton) {
        downloadImage(imageURL: movieImageURL!)
    }
    
    
    func resetCell(){
        movieImageView.image = nil
        titleLabel.text = nil
        titleOriginalLabel.text = nil
        descriptionLabel.text = nil
        errorDescriptionLabel.isHidden = true
        errorButton.isHidden = true
    }
}
