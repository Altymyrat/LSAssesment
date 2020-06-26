//
//  GameSpec.swift
//  LSAssesmentTests
//
//  Created by M.J. on 26.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import XCTest
@testable import LSAssesment

class GameSpec: XCTestCase {

    var viewModel: ResultVM!
    
    override func setUp() {
        super.setUp()
        let genreModel = [Genres(name: "Action")]
        let resultModel = Results(id: 3939,
                                  name: "GTA V",
                                  backgroundImage: "https://www.image.com/gtav",
                                  metacritic: 23,
                                  genres: genreModel)
        viewModel = ResultVM(model: resultModel)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testGameSpec() {
        XCTAssertEqual(viewModel.id, 3939)
        XCTAssertNotEqual(viewModel.id, 0)
        XCTAssertEqual(viewModel.backgroundImage, "https://www.image.com/gtav")
        XCTAssertNotEqual(viewModel.backgroundImage, "")
        XCTAssertNotEqual(viewModel.genres, "")
        XCTAssertEqual(viewModel.genres, "Action")
        XCTAssertEqual(viewModel.metacritic, 23)
        XCTAssertNotEqual(viewModel.metacritic, 0)
    }
}
