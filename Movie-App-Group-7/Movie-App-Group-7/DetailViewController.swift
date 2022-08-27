//
//  DetailViewController.swift
//  Movie-App-Group-7
//
//  Created by Mac Pro on 27/08/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageDetailBanner: UIImageView!
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var labelJudul: UILabel!

    @IBOutlet weak var labelIsi: UILabel!
    
    @IBOutlet weak var labelJam: UILabel!
    @IBOutlet weak var labelTahun: UILabel!
    @IBOutlet weak var labelBy: UILabel!
    @IBOutlet weak var labelDetail: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageDetail.image = movie?.movieBanner
        imageDetailBanner.image = movie?.moviePoster
        labelJudul.text = movie?.title
        labelIsi.text = movie?.orginalTitle
        labelJam.text = "\(String(describing: movie?.duration))"
        labelTahun.text = movie?.releaseDate
        labelBy.text = movie?.director
        labelDetail.text = movie?.description
        

        // Do any additional setup after loading the view.
    }


    
}
