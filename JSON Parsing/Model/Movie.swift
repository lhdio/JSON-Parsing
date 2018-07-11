//
//  Movie.swift
//  JSON Parsing
//
//  Created by Raju on 5/31/18.
//  Copyright © 2018 rajubd49. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let id: Int?
    let title: String?
    let overview: String?
    let posterPath: String?
}

struct MovieResponse: Decodable {
    let results: [Movie]
}
