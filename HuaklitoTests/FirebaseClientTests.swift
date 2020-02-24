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
    
    let productClient = FirebaseClient<Product>()
    let userClient = FirebaseClient<User>()
    var products: [Product]? = []
    var imageData : UIImage?


    func testDownloadFruitCollection() {
        let expectation = XCTestExpectation(description: "Download product collection from Firebase.")
        productClient.getCollection(collectionName: .fruit) { data in
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
        productClient.getCollection(collectionName: .vegetables) { data in
            XCTAssertNotNil(data, "No data was downloaded.")
            self.products = data
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        //Test fruits quantity
        XCTAssert(products!.count == 14)
        //Test first element
        XCTAssertNotNil(products![0].name, "No name downloaded")
        XCTAssertNotNil(products![0].unit, "No unit downloaded.")
        XCTAssertNotNil(products![0].price, "No price downloaded.")
        
    }
    
    func testImageDownloaded() {
        let expectation = XCTestExpectation(description: "Download image from Firebase Storage.")
        let productId = "13lkue89jXi1yzPssWDF"
        productClient.downloadImage(storageFolder: "/productPictures", imageFileName: productId) {data in
                XCTAssertNotNil(data, "No data was downloaded.")
            self.imageData = UIImage(data: data!)
                expectation.fulfill()
               }
        wait(for: [expectation], timeout: 10.0)

        XCTAssertNotNil(self.imageData, "No image was created from data.")
        
    }
    
    func testInsertUserToCollection() {
        let expectation = XCTestExpectation(description: "Insert user in collection.")
        let user = User(email: "test@test.mx", deliveryAddress: "Test 1")
        userClient.insertToCollection(collectionName: .users, objectToInsert: user) { error in
            XCTAssertNil(error, "User wasn´t inserted.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testInsertUserToCollectionWithCustomId() {
        let expectation = XCTestExpectation(description: "Insert user in collection.")
        let user = User(email: "test@test.mx", deliveryAddress: "Test 1")
        userClient.insertToCollection(collectionName: .users, id: user.email, objectToInsert: user) { error in
            XCTAssertNil(error, "User wasn´t inserted.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }


}
