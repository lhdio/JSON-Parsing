//
//  MovieTableViewCell.swift
//  JSON Parsing
//
//  Created by Raju on 6/4/18.
//  Copyright © 2018 rajubd49. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setMovie(movie: Movie) {
        titleLabel?.text = movie.title
        overviewLabel?.text = movie.overview
        if let poster = movie.posterPath {
            posterImageView.loadImage(urlString: Constant.PosterImagePrefix + poster)
        } else {
            posterImageView.showUnavailableImage()
        }
    }

}
