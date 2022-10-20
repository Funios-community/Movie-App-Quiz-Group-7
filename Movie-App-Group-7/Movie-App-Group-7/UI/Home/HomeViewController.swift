//
//  HomeViewController.swift
//  Movie-App-Group-7
//
//  Created by Mohammad Azri on 18/10/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    private let viewModel = HomeViewModel(movieNetworkModel: MovieDefaultNetworkModel())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        registerTableViewCell()
        retrieveMovies()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func retrieveMovies() {
        viewModel.retrieveMovies { [weak self] result in
            switch result {
            case .failure(let message):
                print(message)
            case .success:
                self?.movieTableView.reloadData()
            }
        }
    }
    
    private func configureTableView() {
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.showsHorizontalScrollIndicator = false
        movieTableView.showsVerticalScrollIndicator = false
    }
    
    private func registerTableViewCell() {
        movieTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getMovies().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movies = viewModel.getMovies()
        cell.bind(movies[indexPath.row])
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailMovieViewController(nibName: "DetailMovieViewController", bundle: nil) as DetailMovieViewController
        vc.movieId = viewModel.getMovies()[indexPath.row].id
        self.navigationController?.show(vc, sender: self)
    }
}
