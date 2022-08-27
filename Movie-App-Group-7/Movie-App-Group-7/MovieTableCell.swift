//
//  MovieTableCell.swift
//  Movie-App-Group-7
//
//  Created by Mac Pro on 26/08/22.
//

import UIKit

class MovieTableCell: UITableViewCell {

    @IBOutlet weak var ImageMovie: UIImageView!
    @IBOutlet weak var labelHeading: UILabel!
    @IBOutlet weak var labelHead2: UILabel!
    @IBOutlet weak var labelHead3: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
