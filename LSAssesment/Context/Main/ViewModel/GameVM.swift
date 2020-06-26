//
//  GameVM.swift
//  LSAssesment
//
//  Created by M.J. on 24.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

class GameVM: BaseVM {
    private var responseModel: ResponseModel?
    
    func fetchGame(with text: String, nextPage: Bool = false) {
        var page: Int = 1
        if nextPage {
            page += 1
        }
        
        NetworkManager.shared.fetchGameData(requestParameter:
                                            RequestModel(page: "\(page)", page_size: "\(10)", search: text)) { (response, error) in
            if let error = error {
                self.delegate?.failWith(error: error)
                return
            }
            self.responseModel = response
            self.delegate?.succes()
        }
    }
    
    func getResult(at index: Int) -> ResultVM? {
        if let model = responseModel?.results {
            return ResultVM(model: model[index])
        }
        return nil
    }
    
    func getResultModel(at: Int) -> Results? {
        if let model = responseModel {
            return model.results?[at]
        }
        return nil
    }
    
    var resultCount: Int {
        return responseModel?.results?.count ?? 0
    }
}
