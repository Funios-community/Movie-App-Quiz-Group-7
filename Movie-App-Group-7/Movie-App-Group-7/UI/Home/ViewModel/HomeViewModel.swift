//
//  HomeViewModel.swift
//  Movie-App-Group-7
//
//  Created by Mohammad Azri on 18/10/22.
//

import Foundation

class HomeViewModel {
    private var movies = [Movie]()
    
    func retrieveMovies() {
        guard let path = Bundle.main.path(forResource: "dummy_movie", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            let jsonData = try Data(contentsOf: url)
            let result : [Movie]? = try JSONDecoder().decode([Movie].self, from: jsonData)
            
            if let data = result {
                movies = data
            } else {
                print("Fail to parse!")
            }
        } catch {
            print("Terjadi error dengan pesan \(error)")
        }
    }
    
    func getMovies() -> [Movie] {
        self.movies
    }
}
