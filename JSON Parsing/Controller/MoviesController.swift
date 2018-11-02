//
//  MoviesController.swift
//  JSON Parsing
//
//  Created by Raju on 4/17/18.
//  Copyright © 2018 rajubd49. All rights reserved.
//

import UIKit

class MoviesController: UIViewController {

    var moviesTask: URLSessionDataTask!
    var errorHandler = ErrorHandler()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var movieViewModels: [MovieViewModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        loadMovies()
//        Instead of this
//        let movieCellNib = UINib(nibName: Constant.CELL_ID, bundle: nil)
//        tableView.register(movieCellNib, forCellReuseIdentifier: Constant.CELL_ID)
//        Use this with the help of Protocol
        //tableView.register(MovieCell)// To register a cell, which we don't need now
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func initialSetup() {
        tableView.tableFooterView = UIView(frame: .zero)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Movie List"
        errorHandler.viewController = self
    }
    
    private func loadMovies() {
        moviesTask?.cancel()
        
        activityIndicator.startAnimating()
                
        WebServiceClient.sharedInstance.fetchData(urlString: Constant.MovieListURL) { [weak self] (movieResponse: MovieResponse?, error: WebServiceError?) in
            guard let controller = self else { return }

            DispatchQueue.main.async {
                controller.activityIndicator.stopAnimating()
                
                if let movies = movieResponse?.results {
                    controller.movieViewModels = movies.map({ return MovieViewModel(movie: $0)})
                } else if let error = error {
                    controller.errorHandler.handleError(error)
                }
            }
        }
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        loadMovies()
    }
}

extension MoviesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Instead of this
        //let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CELL_ID, for: indexPath) as! MovieCell
        //Use this with the help of Protocol
        let cell = tableView.dequeueReusableCell(for: indexPath) as MovieCell
        let movieViewModel = movieViewModels[indexPath.row]
        cell.movieViewModel = movieViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

