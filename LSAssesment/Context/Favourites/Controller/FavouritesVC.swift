//
//  FavouritesVC.swift
//  LSAssesment
//
//  Created by M.J. on 23.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

class FavouritesVC: BaseVC {

    override var isNavigationBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageTitle = "Favourites"
    }

}
