//
//  HomeViewController.swift
//  Movie-App-Group-7
//
//  Created by Mohammad Azri on 18/10/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        registerTableViewCell()
        viewModel.retrieveMovies()
        self.tabBarController?.tabBar.isHidden = false
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
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "detailMovieController") else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
