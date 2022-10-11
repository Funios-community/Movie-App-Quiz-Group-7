//
//  MovieListViewController.swift
//  Movie-App-Group-7
//
//  Created by Nadia Darin on 24/08/22.
//

import Foundation
import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var movies: [Movie] = []
    var loader = MovieLoader()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .clear
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.title = "Movie List"
        startRefreshing()
        getMovies(firstLoad: true)
        
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesTableView.refreshControl = refreshControl
        moviesTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        moviesTableView.separatorStyle = .singleLine
    }
    
    @objc
    func refresh() {
        bindData(with: [])
        getMovies(firstLoad: false)
    }
    
    func startRefreshing() {
        refreshControl.beginRefreshing()
    }
    
    func getMovies(firstLoad: Bool) {
        //        self.loadingIndicator.isHidden = false
        //        if let url = URL(string: "https://ghibliapi.herokuapp.com/films") {
        //            URLSession(configuration: .default).dataTask(with: url) { data, urlResponse, error in
        //                if let data = data {
        //                    let decoder = JSONDecoder()
        //                    do {
        //                        let decodedData = try decoder.decode([RemoteMovie].self, from: data)
        //
        //                        DispatchQueue.main.async {
        //                            self.refreshControl.endRefreshing()
        //                            self.loadingIndicator.isHidden = true
        //                            self.bindData(with: decodedData)
        //                        }
        //
        //                    } catch  {
        //                        print("Something went wrong")
        //                        self.loadingIndicator.isHidden = true
        //                    }
        //
        //                }
        //            }.resume()
        //        }
        loader.getMovieList { result in
            self.loadingIndicator.isHidden = false
            switch result {
            case .success(let movies):
                self.bindData(with: movies)
            case .failure(_):
                self.loadingIndicator.isHidden = true
            }
            
        }
    }
    
    func bindData(with movies: [Movie]) {
        self.refreshControl.endRefreshing()
        self.loadingIndicator.isHidden = true
        self.movies = movies.shuffled()
        self.moviesTableView.reloadData()
    }
}

// MARK: TableView DataSource
extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        
        cell.setUpData(movie: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let cell = cell as! MovieTableViewCell
        
        cell.downloadImage(imageURL: movie.movieBanner)
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! MovieTableViewCell
        cell.cancelDownloadAndRemoveImage()
    }
}

// MARK: TableView Delegate
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailPage = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil) as MovieDetailViewController
        
        detailPage.movieID = movies[indexPath.row].id
        
        
        self.navigationController?.show(detailPage, sender: self)
    }
}

