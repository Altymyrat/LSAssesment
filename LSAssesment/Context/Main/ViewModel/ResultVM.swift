//
//  ResultVM.swift
//  LSAssesment
//
//  Created by M.J. on 24.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

class ResultVM {
    private let model: Results
    
    init(model: Results) {
        self.model = model
    }
    
    var name: String {
        return model.name ?? ""
    }
    
    var backgroundImage: String {
        return model.backgroundImage ?? ""
    }
    
    var metacritic: Int {
        return model.metacritic ?? 0
    }
    
    var genres: String {
        var genre = [String]()
        guard let model = model.genres else { return "" }
        for index in model.indices {
            genre.append(model[index].name)
        }
        return genre.joined(separator: ", ")
    }
}
