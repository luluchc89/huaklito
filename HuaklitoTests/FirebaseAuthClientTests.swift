//
//  FirebaseAuthClientTests.swift
//  HuaklitoTests
//
//  Created by Ma. de Lourdes Chaparro Candiani on 22/02/20.
//  Copyright © 2020 sgh. All rights reserved.
//

import XCTest
import Firebase
@testable import Huaklito

class FirebaseAuthClientTests: XCTestCase {
    
    let authClient = FirebaseAuthClient()
    var auth : AuthDataResult?


    func testCreateUser() {
        let expectation = XCTestExpectation(description: "Create new user with Firebase Auth")
        authClient.createUser(email: "test@test.com", pass: "test123", address: "Test") { (auth,error) in
            XCTAssertNotNil(auth, "User was not created")
            self.auth = auth
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        
        XCTAssert(auth?.user.email == "test@test.com")
    }
    
    func testSignInWithCreatedUser() {
        let expectation = XCTestExpectation(description: "Sign in using existing user")
        authClient.signIn(email: "test@test.com", password: "test123") { error in
            XCTAssertNil(error, "User didn´t sign in.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        
    }


}
