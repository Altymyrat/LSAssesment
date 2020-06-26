//
//  DetailVM.swift
//  LSAssesment
//
//  Created by M.J. on 26.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

class DetailVM: BaseVM {
    private var responseModel: DetailModel?
    
    func fetchDetail(by id: Int) {
        NetworkManager.shared.fetchGameDetail(id: "\(id)") { (response, error) in
            if let error = error {
                self.delegate?.failWith(error: error)
                return
            }
            self.responseModel = response
            self.delegate?.succes()
        }
    }
    
    var name: String {
        return self.responseModel?.name ?? ""
    }
    
    var desc: String {
        return self.responseModel?.description ?? ""
    }
    
    var imageString: String {
        return self.responseModel?.backgroundImage ?? ""
    }
    
    var redditUrl: URL? {
        return URL(string: self.responseModel?.redditUrl ?? "")
    }
    
    var websiteUrl: URL? {
        return URL(string: self.responseModel?.website ?? "")
    }
}
