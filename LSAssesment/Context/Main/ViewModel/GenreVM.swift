//
//  GenreVM.swift
//  LSAssesment
//
//  Created by M.J. on 24.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

class GenreVM {
    private var responseModel: Genres
    
    init(model: Genres) {
        responseModel = model
    }
    
    var name: String {
        return responseModel.name
    }
}
