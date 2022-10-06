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
        let url = URL(string: "https://ghibliapi.herokuapp.com/films/\(id!)")!
     
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let decoder = JSONDecoder()
                let movie = try decoder.decode(APIGhibli.self, from: data!)
                
                //binding data detail
                self.bindData(movie: movie)
            } catch {
                print("Error \(error)")
            }
        }.resume()
    }

    func bindData(movie: APIGhibli) {
//        bannerImageView.image = movie.movieBanner
//        posterImageView.image = movie.moviePoster
        bannerImageView.kf.setImage(with: movie.movieBanner)
        posterImageView.kf.setImage(with: movie.image)
        DispatchQueue.main.async {
            self.titleLabel.text = movie.title
            self.originalTitleLabel.text = movie.originalTitle
            self.durationLabel.text = movie.runningTime
            self.releaseDateLabel.text = movie.releaseDate
            self.descriptionLabel.text = movie.remoteMovieDescription
        }
       
    }

}
