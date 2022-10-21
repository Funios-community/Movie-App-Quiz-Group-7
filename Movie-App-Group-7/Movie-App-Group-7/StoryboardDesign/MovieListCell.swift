//
//  MovieListCell.swift
//  Movie-App-Group-7
//
//  Created by Agung Luo on 26/08/22.
//

import UIKit
import Kingfisher

class MovieListCell: UITableViewCell {
    @IBOutlet var Banner: UIImageView!
    @IBOutlet var Title: UILabel!
    @IBOutlet var OriginalTitle: UILabel!
    @IBOutlet var Description: UILabel!
    
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var imageContainer: UIView!
    
    private var downloadTask: URLSessionDataTask?
    private var movie: Movie!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func bindData(with movie: Movie) {
        Title.text = movie.title
        OriginalTitle.text = movie.orginalTitle
        Description.text = movie.description
        self.movie = movie
        getMovieBanner()
    }
    
    func cancelDownloadImageKingfisher() {
        Banner.kf.cancelDownloadTask()
        Banner.image = nil
    }
    
    // Loading -> Tampilin Loading
    // Success -> Tampilin Data
    // Failed -> Tampilin Error
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func retryImageDownload(_ sender: Any) {
        getMovieBanner()
    }
    //function untuk menampilkan banner
    func getMovieBanner () {
        imageContainer.isShimmering = true
        //mengetes untuk shimmering dengan memberi delay
        //        DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
        self.downloadTask = URLSession.shared.dataTask(with: movie.movieBanner) { data, response, error in
            DispatchQueue.main.async {
                //            let url = URL(string: self.movie.movieBanner)
                //cheatsheet kingfisher completion handler untuk tidak menampilkan gambar, no internet connection
                //            self.Banner.kf.setImage(with: url, placeholder: nil, options: nil) { result in
                self.Banner.kf.setImage(with: self.movie.movieBanner) { result in
                    self.imageContainer.isShimmering = false
                    switch result {
                    case .success:
                        break
                    case .failure:
                        self.retryButton.isHidden = false
                    
                }
                
                }
            }
            //        }
        }
        downloadTask?.resume()
    }
}

