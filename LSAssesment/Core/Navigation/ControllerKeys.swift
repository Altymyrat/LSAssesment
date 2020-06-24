//
//  ControllerKeys.swift
//  LSAssesment
//
//  Created by M.J. on 23.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

typealias ControllerKey = String

let kControllerMap: [ControllerKey: (classType: UIViewController.Type, title: String)] =
    [ControllerKeys.splash.rawValue: (SplashVC.self, ""),
     ControllerKeys.tabbar.rawValue: (TabBarController.self, ""),
     ControllerKeys.main.rawValue: (MainVC.self, "Games"),
     ControllerKeys.favourites.rawValue: (FavouritesVC.self, "Favorites"),
     ControllerKeys.detailScreen.rawValue: (DetailScreenVC.self, "")
    ]


enum ControllerKeys: ControllerKey {
    case splash
    case main
    case tabbar
    case favourites
    case detailScreen
}

var kControllerTree: [ControllerKey: (index: Int, iconName: String)] = [
    ControllerKeys.main.rawValue: (0, "games"),
    ControllerKeys.favourites.rawValue: (1, "favourites")
    ]

var kControllerTreeKeys: [ControllerKey] {
    return kControllerTree.keys.sorted { kControllerTree[$0]!.index < kControllerTree[$1]!.index }
}
