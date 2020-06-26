//
//  ResultModel.swift
//  LSAssesment
//
//  Created by M.J. on 24.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

struct Results: Codable {
    let id: Int
    let name: String?
    let backgroundImage: String?
    let metacritic: Int?
    let genres: [Genres]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case backgroundImage = "background_image"
        case metacritic = "metacritic"
        case genres = "genres"
    }
}
