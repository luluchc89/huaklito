//
//  GetProductsServiceTests.swift
//  HuaklitoTests
//
//  Created by Ma. de Lourdes Chaparro Candiani on 13/02/20.
//  Copyright © 2020 sgh. All rights reserved.
//

import XCTest
@testable import Huaklito

class GetProductsServiceTests: XCTestCase {
    
    var productsService = GetProductsService()
    var fruits: [Product]? = [] /*{
        didSet {
            self.postsCollection.reloadData()
        }
    }*/

    func testProductsObtained() {
        let expectation = XCTestExpectation(description: "Download product collection from Firebase.")
        productsService.getFruits { data in
            XCTAssertNotNil(data, "No data was downloaded.")
            self.fruits = data
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        //Test fruits quantity
        XCTAssert(fruits!.count == 12)
        //Test first element
        XCTAssertNotNil(fruits![0].name, "No name downloaded")
        XCTAssertNotNil(fruits![0].unit, "No unit downloaded.")
        XCTAssertNotNil(fruits![0].price, "No price downloaded.")
        
    }


}
