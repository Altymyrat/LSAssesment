//
//  SplashVC.swift
//  LSAssesment
//
//  Created by M.J. on 23.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

class SplashVC: BaseVC {

    // MARK: - IBOutlet:
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - Override func
    override var isNavigationBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delay(3) {
            Coordinator.shared.requestNavigation(.tabbar)
        }
    }
}
