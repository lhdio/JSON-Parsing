//
//  HTTPURLResponse.swift
//  JSON Parsing
//
//  Created by Raju on 12/7/18.
//  Copyright © 2018 rajubd49. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}
