//
//  UIImage+Extension.swift
//  Movie-App-Group-7
//
//  Created by Mohammad Azri on 19/10/22.
//

import Foundation
import UIKit

extension UIImageView {
    func loadFromUrl(url: URL) {
        DispatchQueue.global().async { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            } catch {
                print(error)
            }
        }
    }
}
