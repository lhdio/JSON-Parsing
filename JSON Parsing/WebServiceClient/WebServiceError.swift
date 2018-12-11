//
//  WebServiceError.swift
//  JSON Parsing
//
//  Created by Raju on 4/17/18.
//  Copyright © 2018 rajubd49. All rights reserved.
//

import Foundation

enum WebServiceError: Error {
    case network
    case fetch
    case decode
    case other
    
    var reason: String {
        switch self {
        case .network:
            return "The internet connection is lost"
        case .fetch:
            return"Failed to fetch data"
        case .decode:
            return "Failed to decode json"
        case .other:
            return "Unfortunately something went wrong"
        }
    }
}


