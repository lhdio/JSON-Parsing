//
//  ErrorHandler.swift
//  JSON Parsing
//
//  Created by Raju on 6/22/18.
//  Copyright © 2018 rajubd49. All rights reserved.
//

import Foundation
import UIKit

class ErrorHandler: NSObject {

    var viewController: MoviesController?
    
    private func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    func handleError(_ error: WebServiceError) {
        showErrorAlert(with: error.reason)
    }
}
