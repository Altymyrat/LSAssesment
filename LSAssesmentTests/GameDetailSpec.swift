//
//  GameDetailSpec.swift
//  LSAssesmentTests
//
//  Created by M.J. on 26.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import XCTest
@testable import LSAssesment

class GameDetailSpec: XCTestCase {

    var detailSpec: DetailModel!
    
    override func setUp() {
        super.setUp()
        detailSpec = DetailModel(name: "FIFA 20",
                                 description: "Lorem ipsum",
                                 backgroundImage: "https://www.image.com/fifa20",
                                 website: "https://www.fifa.com",
                                 redditUrl: "https://www.reddit.com/fifa20")
    }
    
    override func tearDown() {
        detailSpec = nil
        super.tearDown()
    }
    
    func testDetailSpecs() {
        XCTAssertEqual(detailSpec.name, "FIFA 20")
        XCTAssertNotEqual(detailSpec.name, "")
        XCTAssertEqual(detailSpec.description, "Lorem ipsum")
        XCTAssertNotEqual(detailSpec.description, "")
        XCTAssertEqual(detailSpec.redditUrl, "https://www.reddit.com/fifa20")
        XCTAssertNotEqual(detailSpec.redditUrl, "")
        XCTAssertEqual(detailSpec.website, "https://www.fifa.com")
        XCTAssertNotEqual(detailSpec.website, "")
    }

}
