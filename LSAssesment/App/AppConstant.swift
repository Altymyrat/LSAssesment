//
//  AppConstant.swift
//  LSAssesment
//
//  Created by M.J. on 24.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

struct AppColor {
    
    static let splashBackground: UIColor = .rgb(red: 170, green: 79, blue: 112)
    static let headerBackground: UIColor = .rgb(red: 248, green: 248, blue: 248, alpha: 0.92)
    static let navbarColor: UIColor = .hexString("007AFF")
    static let selectedCellColor: UIColor = .hexString("E0E0E0")
    static let metacriticColor: UIColor = .hexString("D80000")
    static let genreColor: UIColor = .hexString("8A8A8F")
    static let detailCellColor: UIColor = .hexString("313131")
    
}

struct AppString {
    //TODO: Localization string can be using here
    static let gameVCTitle: String = "Games"
    static let favouritesVCTitle: String = "Favourites"
    static let notFoundFavourite: String = "There is no favourites found"
    static let notGameSearched: String = "No game has been searched."
    static let searchPlaceHolder: String = "Search for the games"
    static let gameDesc: String = "Game Description"
    static let readMoreButton: String = "Read more..."
    static let contractButton: String = "Read less"
    static let visitReddit: String = "Visit reddit"
    static let visitWebsite: String = "Visit website"
    static let barButtonFavourite: String = "Favourite"
    static let barButtonFavourited: String = "Favourited"
    static let alertTitle: String = "Warning"
    static let alertDesc: String = "Would you like to delete the game from Favourites?"
    static let alerYesButton: String = "Yes"
    static let alertCancelButton: String = "Cancel"
}

struct AppEndpoint {
    static let url = "https://api.rawg.io/api/games"
}
