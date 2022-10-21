//
//  MovieListViewController.swift
//  Movie-App-Group-7
//
//  Created by Agung Luo on 30/08/22.
//
import UIKit
import Kingfisher
class MovieListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var listMovie: [Movie] = []
    
    @IBOutlet var movieListTV: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var imageContainer: UIView!
    //property for refresh
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl ()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    var loader = MovieLoader()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //cell ini merupakan MovieListCell, dan sudah memiliki properti
        let cell = tableView.dequeueReusableCell(withIdentifier: "XibMovieList") as! MovieListCell
        //Assign untuk menunjukkan movie yang berbeda,
        let movies = listMovie[indexPath.row]
        //        cell.Banner.image = Movie.movieBanner
        cell.bindData(with: movies)
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        refreshControl.beginRefreshing()
        getMovieListData()
    }
    
    func showErrorLabel (with message: String){
        errorLabel.isHidden = false
        errorLabel.text = message
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    @objc
    func refresh (){
        listMovie.removeAll()
        getMovieListData()
    }
    func startRefreshing() {
        refreshControl.beginRefreshing()
    }
    
    func stopRefreshing() {
        refreshControl.endRefreshing()
    }
    //ketika klik cell, mengarah ke movie details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetails (nibName: "MovieDetails", bundle: nil)
        //        vc.movie = listMovie[indexPath.row]
        //        self.present(vc, animated: true)
        vc.id = listMovie[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! MovieListCell
        
        cell.getMovieBanner()
    }
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! MovieListCell
        cell.cancelDownloadImageKingfisher()
    }
}

//MARK: Networking
extension MovieListViewController {
    //call API
    func getMovieListData (){
        loader.getMovieListData { result in
            self.stopRefreshing()
            switch result {
            case .success (let movies):
                self.bindData(with: movies)
            case .failure (let error):
            self.showErrorLabel(with: error)
        }
    }
}

func transformJsonDataToMovieList(with data: Data) throws -> [MovieList] {
    let decoder = JSONDecoder()
    let movies = try decoder.decode([MovieList].self, from: data)
    return movies
}
//Bind Data
func bindData (with movies: [Movie]){
    DispatchQueue.main.async {
        self.listMovie = movies.shuffled()
        self.movieListTV.reloadData()
        
    }
}

//setup table view
func setupTableView(){
    movieListTV.delegate = self
    movieListTV.dataSource = self
    //register XIB dengan table view bernama movieListTV,
    self.movieListTV.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: "XibMovieList")
    movieListTV.refreshControl = refreshControl
}

}
