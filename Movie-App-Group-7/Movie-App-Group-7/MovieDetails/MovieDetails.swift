//
//  MovieDetails.swift
//  Movie-App-Group-7
//
//  Created by Agung Luo on 26/08/22.
//

import Foundation
import UIKit
import Kingfisher

class MovieDetails: UIViewController {
    var id: String?
    @IBOutlet var bannerImage: UIImageView!
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var durationTime: UILabel!
    @IBOutlet var releasedDate: UILabel!
    @IBOutlet var Director: UILabel!
    @IBOutlet weak var Description: UILabel!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl ()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    //    var movie: MovieList?
    // Configure the view for the selected state
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.beginRefreshing()
        getMovieDetail()
    }
    @objc
    func refresh (){
        getMovieDetail()
    }
    //MARK: Movie Detail
    //call API untuk movie detail
    func getMovieDetail () {
        let url = URL(string: "https://ghibliapi.herokuapp.com/films/\(id!)")!
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            self.refreshControl = self.refreshControl
            do {
                let decoder = JSONDecoder()
                let movieDetail = try decoder.decode (MovieList.self, from:data!)
                
                //bindingData detail
                DispatchQueue.main.async {
                    self.bindData(movie: movieDetail)
                }
                
            } catch {
                print ("Error")
            }
        }.resume()
    }
    func setupMovieDetail (){
        
    }
    //func bindData for MovieDetail
    private func bindData (movie: MovieList){
        titleLabel.text = movie.title
        let runningTime = convertDurationToHoursMinutes(runningTime: movie.runningTime)
        durationTime.text = runningTime
        releasedDate.text = movie.releaseDate
        Director.text = movie.director
        Description.text = movie.movieListDescription
        downloadImage(with: movie.movieBanner, for: bannerImage)
        downloadImage(with: movie.image, for: posterImage)
        
    }
    
    //function untuk mengubah tampilan durasi dengan 1h 00 m
    func convertDurationToHoursMinutes(runningTime: String) -> String {
        guard let runningTime = Int(runningTime) else {return "\(runningTime)m"}
        return "\(runningTime / 60)h \(runningTime % 60)m"
    }
    
    //function untuk mendownload image dari url untuk banner dan poster di movie detail
    func downloadImage(with url: URL, for imageView: UIImageView) {
//        guard let url = URL(string: url) else {return}
        let downloadTask = URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data else {return}
            
            if let downloadedImage = UIImage(data:data){
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
