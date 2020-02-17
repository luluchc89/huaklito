//
//  FirebaseClientTests.swift
//  HuaklitoTests
//
//  Created by Ma. de Lourdes Chaparro Candiani on 16/02/20.
//  Copyright © 2020 sgh. All rights reserved.
//

import XCTest
@testable import Huaklito

class FirebaseClientTests: XCTestCase {
    
    let client = FirebaseClient<Product>()
    var products: [Product]? = []


    func testDownloadFruitCollection() {
        let expectation = XCTestExpectation(description: "Download product collection from Firebase.")
        client.getFirebaseCollection(collectionName: .fruit) { data in
            XCTAssertNotNil(data, "No data was downloaded.")
            self.products = data
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        //Test fruits quantity
        XCTAssert(products!.count == 12)
        //Test first element
        XCTAssertNotNil(products![0].name, "No name downloaded")
        XCTAssertNotNil(products![0].unit, "No unit downloaded.")
        XCTAssertNotNil(products![0].price, "No price downloaded.")
        
    }
    
    func testDownloadVegetableCollection() {
        let expectation = XCTestExpectation(description: "Download product collection from Firebase.")
        client.getFirebaseCollection(collectionName: .vegetables) { data in
            XCTAssertNotNil(data, "No data was downloaded.")
            self.products = data
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        //Test fruits quantity
        XCTAssert(products!.count == 12)
        //Test first element
        XCTAssertNotNil(products![0].name, "No name downloaded")
        XCTAssertNotNil(products![0].unit, "No unit downloaded.")
        XCTAssertNotNil(products![0].price, "No price downloaded.")
        
    }


}
