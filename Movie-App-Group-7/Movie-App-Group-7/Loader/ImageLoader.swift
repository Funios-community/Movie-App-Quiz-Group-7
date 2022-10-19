//
//  ImageLoader.swift
//  Movie-App-Group-7
//
//  Created by Nadia Darin on 11/10/22.
//

import Foundation
import UIKit
import MapKit


enum ImageResult {
    case success(UIImage)
    case failure(String)
}

class ImageLoader {
    
    func downloadImageWithURLSession(url: String, completion: @escaping (ImageResult) -> Void) {
        if let imageURL = URL(string: url) {
            let session = URLSession(configuration: .default)
            
            session.dataTask(with: imageURL) { (data, response, error) in
                if let e = error {
                    completion(.failure(e.localizedDescription))
                    
                } else {
                    if let _ = response as? HTTPURLResponse {
                        
                        if let imageData = data {
                            if let image = UIImage(data: imageData) {
                                DispatchQueue.main.sync {
                                    completion(.success(image))
                                }
                            } else {
                                completion(.failure("Error: Can not converted data to UIImage"))
                            }
                        } else {
                            completion(.failure("Error: Data is nil"))
                        }
                    } else {
                        completion(.failure("Error: Response is not HTTPURLResponse"))
                    }
                }
            }.resume()
        } else {
            completion(.failure("Error: Can not converted url String to URL object"))
        }
    }
    
    
}
