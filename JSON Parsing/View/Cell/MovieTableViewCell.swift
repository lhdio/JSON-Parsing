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
            posterImageView?.loadImageFromUrlString(urlString: Constant.PosterImagePrefix + poster)
        } else {
            posterImageView?.image = UIImage(named: "unavailable.png")
        }
    }

}

extension UIImageView {
    func loadImageFromUrlString(urlString: String) {
        if let url = URL(string: urlString) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
