//
//  DataManager.swift
//  LSAssesment
//
//  Created by M.J. on 25.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
    // MARK: - Private parameter
    private var _gameID: Int = 0
    
    // MARK: - Parameters
    var currentGamesData: Results?
    
    var gameID: Int {
        get {
            return _gameID
        }
        set {
            if !visitedID.contains(newValue) {
                visitedID.append(newValue)
            }
            _gameID = newValue
        }
    }
    
    var visitedID: [Int] {
        get {
            if let visitedID = UserDefaults.standard.value(forKey: "visitedID") as? [Int] {
                return visitedID
            } else {
                return []
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "visitedID")
        }
    }
    
    private var favouriteGames: [Results] {
        get {
            if let list = UserDefaults.standard.value(forKey: "favouriteGames") as? Data,
                let model = try? JSONDecoder().decode([Results].self, from: list) {
                return model
            }
            else { return [] }
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: "favouriteGames")
            }
        }
    }
    
    /// Save game to favorite when user hit Favourite button
    func saveGameToFavourite() {
        if let result = currentGamesData, currentGamesData?.id == gameID {
            if isAddedToFavourite() { return }
            favouriteGames.append(result)
        }
    }
    
    func isAddedToFavourite() -> Bool {
        let isSaved = favouriteGames.contains { (result) -> Bool in
            result.id == gameID
        }
        return isSaved
    }
    
    /// For use in FavouriteVC disoplay favourite games
    func getFavouriteGames() -> [ResultVM] {
        var result: [ResultVM] = []
        for index in favouriteGames.indices {
            result.append(ResultVM(model: favouriteGames[index]))
        }
        return result
    }
}
