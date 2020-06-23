//
//  MainVC.swift
//  LSAssesment
//
//  Created by M.J. on 23.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

class MainVC: BaseVC {

    override var isNavigationBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageTitle = "Games"
        delay(2) {
            Coordinator.shared.requestNavigation(.detailScreen)
        }
    }

}
