//
//  GenreModel.swift
//  LSAssesment
//
//  Created by M.J. on 24.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

struct Genres: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}
