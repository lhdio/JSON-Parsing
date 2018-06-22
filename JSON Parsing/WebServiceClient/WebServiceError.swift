//
//  WebServiceError.swift
//  JSON Parsing
//
//  Created by Raju on 4/17/18.
//  Copyright © 2018 rajubd49. All rights reserved.
//

import Foundation

public enum WebServiceError: Error {
    case noInternetConnection
    case decodeFailed
    case fetchFailed
    case other
}


