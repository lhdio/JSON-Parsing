//
//  MovieViewModel.swift
//  JSON Parsing
//
//  Created by Raju on 7/10/18.
//  Copyright © 2018 rajubd49. All rights reserved.
//

import UIKit

struct MovieViewModel {
    
    var id: Int?
    var title: String?
    var overview: String?
    var posterImageUrl: String?

    // Dependency Injection
    init(movie: Movie) {
        id = movie.id
        title = movie.title
        overview = movie.overview
        
        if let posterPath = movie.posterPath {
            posterImageUrl = Constant.PosterImagePrefix + posterPath
        } else {
            posterImageUrl = nil
        }
    }
}
