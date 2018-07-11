//
//  MovieTableViewCell.swift
//  JSON Parsing
//
//  Created by Raju on 6/4/18.
//  Copyright © 2018 rajubd49. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var movieViewModel: MovieViewModel! {
        didSet{
            titleLabel?.text = movieViewModel.title
            overviewLabel?.text = movieViewModel.overview
            if let posterImageUrl = movieViewModel.posterImageUrl {
                posterImageView.loadImage(urlString:posterImageUrl)
            } else {
                posterImageView.showUnavailableImage()
            }

        }
    }
}
