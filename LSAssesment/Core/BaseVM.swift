//
//  BaseVM.swift
//  LSAssesment
//
//  Created by M.J. on 26.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func failWith(error: String)
    func succes()
}

class BaseVM {
    weak var delegate: ViewModelDelegate?
}
