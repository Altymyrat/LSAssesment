//
//  RequestModel.swift
//  LSAssesment
//
//  Created by M.J. on 24.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

struct RequestModel {
    var page: String
    var page_size: String
    var search: String
    
    var convertQueryParams: [String: String] {
        var dict: [String: String] = [:]
        dict["page"] = self.page
        dict["page_size"] = self.page_size
        dict["search"] = self.search
        return dict
    }
}
