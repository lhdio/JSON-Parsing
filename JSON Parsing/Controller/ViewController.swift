//
//  ViewController.swift
//  JSON Parsing
//
//  Created by Raju on 4/17/18.
//  Copyright © 2018 rajubd49. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var moviesTask: URLSessionDataTask!
    var errorHandler = ErrorHandler()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var movies: [Movie] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Movie List"
        errorHandler.viewController = self
        loadMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        loadMovies()
    }
    
    private func loadMovies() {
        moviesTask?.cancel()
        
        activityIndicator.startAnimating()
                
        WebServiceClient.sharedInstance.fetchData(urlString: Constant.MovieListURL) { [weak self] (movieResponse: MovieResponse?, error: WebServiceError?) in
            guard let controller = self else { return }

            DispatchQueue.main.async {
                controller.activityIndicator.stopAnimating()
                
                if let movies = movieResponse?.results {
                    controller.movies = movies
                } else if let error = error {
                    self?.errorHandler.handleError(error)
                }
            }
        }
    }
    
    private func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func handleError(_ error: WebServiceError) {
        switch error {
        case .noInternetConnection:
            showErrorAlert(with: "The internet connection is lost")
        case .fetchFailed:
            showErrorAlert(with: "Failed to fetch data")
        case .decodeFailed:
            showErrorAlert(with: "Failed to decode json")
        case .other:
            showErrorAlert(with: "Unfortunately something went wrong")
        }
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CELL_ID, for: indexPath) as! MovieTableViewCell
        let movie = self.movies[indexPath.row]
        cell.setMovie(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

