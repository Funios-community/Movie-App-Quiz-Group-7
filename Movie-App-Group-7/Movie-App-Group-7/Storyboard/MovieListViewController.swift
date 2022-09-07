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
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.title = "Movie List"
        getMovies()
        
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        moviesTableView.separatorStyle = .singleLine
    }
    
    func getMovies() {
        print("movies")
        if let url = URL(string: "https://ghibliapi.herokuapp.com/films") {
            URLSession(configuration: .default).dataTask(with: url) { data, urlResponse, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode([Movie].self, from: data)
                        
                        DispatchQueue.main.async {
                            self.movies = decodedData
                            
                            self.moviesTableView.reloadData()
                        }

                    } catch  {
                        print("Something went wrong")
                    }
                    
                }
            }.resume()
        }
    }


}

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
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailPage = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil) as MovieDetailViewController
        
        detailPage.movieID = movies[indexPath.row].id


        self.navigationController?.show(detailPage, sender: self)
    }
}

