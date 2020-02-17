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
    var products: [[Product]]? = []
    

    func testProductsObtained() {
        let expectation = XCTestExpectation(description: "Download product collections from Firebase.")
        productsService.getProducts {data in
            XCTAssertNotNil(data, "No data was downloaded.")
            self.products = data
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        //Test number of product categories
        XCTAssert(products!.count == 5)
        
        //Test first element
        XCTAssertNotNil(products![0][0].name, "No name downloaded")
        XCTAssertNotNil(products![0][0].unit, "No unit downloaded.")
        XCTAssertNotNil(products![0][0].price, "No price downloaded.")
        
    }


}
