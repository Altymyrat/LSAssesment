//
//  GameVM.swift
//  LSAssesment
//
//  Created by M.J. on 24.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

protocol GameVMDelegate: class {
    func failWith(error: String)
    func succes()
}

class GameVM {
    private var responseModel: ResponseModel?
    
    weak var delegate: GameVMDelegate?
    
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
    
    var resultCount: Int {
        return responseModel?.results?.count ?? 0
    }
}
