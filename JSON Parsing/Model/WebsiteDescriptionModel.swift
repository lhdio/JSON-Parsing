//
//  WebsiteDescriptionModel.swift
//  JSON Parsing
//
//  Created by BS-195 on 4/17/18.
//  Copyright © 2018 rajubd49. All rights reserved.
//

import Foundation

struct WebsiteDescription:Decodable {
    let name: String
    let description: String
    let courses: [Course]
}
