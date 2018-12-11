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
    private var totalCount = 0
    private var currentPage = 1
    private var isFetchInProgress = false

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
        fetchMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func initialSetup() {
        tableView.prefetchDataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Movie List"
        errorHandler.viewController = self
    }
    
    private func fetchMovies() {
        guard !isFetchInProgress else { return }
        isFetchInProgress = true
        moviesTask?.cancel()
        activityIndicator.startAnimating()

        let urlRequest = URLRequest(url: URL(string: Constant.BaseURL)!)
        let parameters = ["page": "\(currentPage)", "query": "marvel", "api_key": "1b5adf76a72a13bad99b8fc0c68cb085"]
        let encodedURLRequest = urlRequest.encode(with: parameters)
        
        WebServiceClient.sharedInstance.fetchData(urlRequest: encodedURLRequest) { [weak self] (movieResponse: MovieResponse?, error: WebServiceError?) in
            guard let weakSelf = self else { return }

            if let movieResponse = movieResponse {
                weakSelf.onFetchComplete(forResponse: movieResponse)
            } else if let error = error {
                weakSelf.onFetchError(forError: error)
            }
        }
    }
}

extension MoviesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(for: indexPath) as MovieCell
        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none)
        } else {
            cell.configure(with: movieViewModels[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension MoviesController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            fetchMovies()
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        //TODO
    }
    
}

private extension MoviesController {
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= self.movieViewModels.count
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
    
    private func calculateIndexPathsToReload(from newMovies: [Movie]) -> [IndexPath] {
        let startIndex = self.movieViewModels.count - newMovies.count
        let endIndex = startIndex + newMovies.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    private func onFetchComplete(forResponse response:MovieResponse) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            let movies = response.results
            self.currentPage += 1
            self.isFetchInProgress = false
            self.totalCount = response.totalResults
            self.movieViewModels.append(contentsOf: movies.map({ return MovieViewModel(movie: $0)}))
            if (response.page) > 1 {
                let newIndexPathsToReload = self.calculateIndexPathsToReload(from: movies)
                let indexPathsToReload = self.visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
                self.tableView.reloadRows(at: indexPathsToReload, with: .automatic)
            }
        }
    }
    
    private func onFetchError(forError error:WebServiceError) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.isFetchInProgress = false
            self.errorHandler.handleError(error)
        }
    }
}

