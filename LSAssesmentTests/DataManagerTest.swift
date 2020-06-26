//
//  DataManagerTest.swift
//  LSAssesmentTests
//
//  Created by M.J. on 26.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import XCTest
@testable import LSAssesment

class DataManagerTest: XCTestCase {
    var dataManager: DataManager?
    
    override func setUp() {
        dataManager?.gameID = 3939
        let genreModel = [Genres(name: "Action")]
        dataManager?.currentGamesData = Results(id: 3939,
                                                name: "GTA V",
                                                backgroundImage: "https://www.image.com/gtav",
                                                metacritic: 23,
                                                genres: genreModel)
        
    }
    
    
    func testDataManager() {
        guard let manager = dataManager else  { return }
        XCTAssertEqual(manager.gameID, 3939)
        XCTAssertNotEqual(manager.gameID, 0)
        XCTAssertNotNil(manager.currentGamesData)
        XCTAssertEqual(manager.visitedID, [3939])
    }
}
