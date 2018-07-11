//
//  JSON_ParsingTests.swift
//  JSON ParsingTests
//
//  Created by BS-195 on 4/17/18.
//  Copyright © 2018 rajubd49. All rights reserved.
//

import XCTest
@testable import JSON_Parsing

class JSON_ParsingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMovieViewModel() {
        let movie = Movie(id: 1, title: "Movie", overview: "Overview", posterPath: "Image")
        let movieViewModel = MovieViewModel(movie: movie)
        
        XCTAssertEqual(movie.title, movieViewModel.title)
        XCTAssertEqual(movie.overview, movieViewModel.overview)
        XCTAssertEqual(Constant.PosterImagePrefix + movie.posterPath!, movieViewModel.posterImageUrl)
    }
    
}
