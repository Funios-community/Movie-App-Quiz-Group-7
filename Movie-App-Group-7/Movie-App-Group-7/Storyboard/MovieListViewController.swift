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
    
    let movies = fakeMovies()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.title = "Movie List"
        
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        moviesTableView.separatorStyle = .singleLine
    }


}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        cell.movieImageView.image = movie.movieBanner
        cell.titleLabel.text = movie.title
        cell.titleOriginalLabel.text = movie.orginalTitle
        cell.descriptionLabel.text = movie.description
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        cell.selectionStyle = .none

        return cell
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailPage = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil) as MovieDetailViewController
        
        detailPage.movie = movies[indexPath.row]


        self.navigationController?.show(detailPage, sender: self)
    }
}

