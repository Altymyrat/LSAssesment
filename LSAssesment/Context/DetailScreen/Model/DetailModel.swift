//
//  DetailModel.swift
//  LSAssesment
//
//  Created by M.J. on 26.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

struct DetailModel: Decodable {
    var name: String?
    var description: String?
    var backgroundImage: String?
    var website: String?
    var redditUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description_raw"
        case backgroundImage = "background_image"
        case website = "website"
        case redditUrl = "reddit_url"
    }
}
