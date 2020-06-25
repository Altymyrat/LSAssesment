//
//  ResponseModel.swift
//  LSAssesment
//
//  Created by M.J. on 24.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

struct ResponseModel: Codable {
    let count: Int?
    let results: [Results]?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case results = "results"
    }
}
