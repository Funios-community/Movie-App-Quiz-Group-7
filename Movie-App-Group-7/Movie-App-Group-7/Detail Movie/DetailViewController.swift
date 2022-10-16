//
//  DetailViewController.swift
//  Movie-App-Group-7
//
//  Created by Mac Pro on 27/08/22.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    var id: String?
    
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
        
        // Do any additional setup after loading the view.
        getMovieDetail()
    }
    
    func getMovieDetail() {
        guard let id = self.id else
        
        {
            return
        }
        let url = URL(string: "https://ghibliapi.herokuapp.com/films/\(id)")!
     
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let decoder = JSONDecoder()
                let movie = try decoder.decode(APIGhibliDetail.self, from: data!)
                
                //binding data detail
                self.bindData(movie: movie)
            } catch {
                print("Error \(error)")
            }
        }.resume()
    }

   private func bindData(movie: APIGhibliDetail) {
//        bannerImageView.image = movie.movieBanner
//        posterImageView.image = movie.moviePoster
//        bannerImageView.kf.setImage(with: movie.movieBanner)
//        posterImageView.kf.setImage(with: movie.image)
//        DispatchQueue.main.async {
    titleLabel.text = movie.title
    originalTitleLabel.text = "\(movie.originalTitle) \(movie.originalTitleRomanised)"
    let runningTime = convertSecondToHourMinutes(runningTime: movie.runningTime)
    durationLabel.text = runningTime
    releaseDateLabel.text = movie.releaseDate
    descriptionLabel.text = movie.remoteMovieDescription
            
            downloadImage(with: movie.movieBanner, for: self.bannerImageView)
            downloadImage(with: movie.image, for: self.posterImageView)

        }

       private func convertSecondToHourMinutes(runningTime: String) -> String {
            guard let runningTime = Int(runningTime) else { return "\(runningTime) m" }
            return "\(runningTime / 60)h \(runningTime % 60)m"
        }
        
      private func downloadImage(with url: URL, for imageView: UIImageView) {
            let downloadTask = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }

                if let downloadedImage = UIImage(data: data) {
                    DispatchQueue.main.sync {
                        imageView.image = downloadedImage
                    }
                } else {
                    print("Error fetching image \(error)")
                }
            }
            downloadTask.resume()
        }
    }

