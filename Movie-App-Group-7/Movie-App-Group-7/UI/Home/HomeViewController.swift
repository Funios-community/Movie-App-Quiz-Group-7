//
//  HomeViewController.swift
//  Movie-App-Group-7
//
//  Created by Mohammad Azri on 18/10/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var movieTableView: UITableView!
    @IBOutlet private weak var errorLabel: UILabel!
    private let viewModel = HomeViewModel(movieNetworkModel: MovieDefaultNetworkModel())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureRefreshControl()
        registerTableViewCell()
        retrieveMovies()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func retrieveMovies(isRefreshing: Bool = false) {
        if isRefreshing {
            self.movieTableView.refreshControl?.beginRefreshing()
        }
        
        viewModel.retrieveMovies { [weak self] result in
            switch result {
            case .failure(_):
                if isRefreshing {
                    self?.movieTableView.refreshControl?.endRefreshing()
                }
                self?.showError(false)
            case .success:
                if isRefreshing {
                    self?.movieTableView.refreshControl?.endRefreshing()
                }
                self?.showError()
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
    
    private func configureRefreshControl() {
        movieTableView.refreshControl = UIRefreshControl()
        movieTableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    @objc private func pullToRefresh() {
        retrieveMovies(isRefreshing: true)
    }
    
    private func registerTableViewCell() {
        movieTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
    }
    
    private func showError(_ isError: Bool = true) {
        errorLabel.isHidden = isError
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else { return }
    
        let movies = viewModel.getMovies()
        guard let url = URL(string: movies[indexPath.row].movieBanner) else { return }
        
        cell.loadImageUsingKingfisher(url: url)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else { return }
        cell.cancelDownloadingImage()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailMovieViewController(nibName: "DetailMovieViewController", bundle: nil) as DetailMovieViewController
        vc.movieId = viewModel.getMovies()[indexPath.row].id
        self.navigationController?.show(vc, sender: self)
    }
}
