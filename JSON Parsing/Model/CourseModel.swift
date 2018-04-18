//
//  CourseModel.swift
//  JSON Parsing
//
//  Created by BS-195 on 4/17/18.
//  Copyright © 2018 rajubd49. All rights reserved.
//

import Foundation

struct Course: Decodable {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
    let numberOfLessons: Int
    
    /* Swift 2, 3
    init(json: [String: Any]) {
        id = json["id"] as? Int ?? -1
        name = json["name"] as? String ?? ""
        link = json["link"] as? String ?? ""
        imageUrl = json["imageUrl"] as? String ?? ""
    }
    */
    
    /* swift 4.0
    private enum CodingKeys: String, CodingKey {
        case numberOfLessons = "number_of_lessons"
        case id, name, link, imageUrl
    }
    */
    
}
