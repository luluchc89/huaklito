//
//  FirebaseAuthClient.swift
//  Huaklito
//
//  Created by Ma. de Lourdes Chaparro Candiani on 22/02/20.
//  Copyright © 2020 sgh. All rights reserved.
//

import Foundation
import Firebase

class FirebaseAuthClient {
    
    let client = FirebaseClient()
    
    func createUser(email : String, pass : String, address: String, userCompletionHandler: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
            if let auth = authResult {
                
                userCompletionHandler(auth,nil)
            } else if let error = error {
                userCompletionHandler(nil, error)
            }
        }
    }
    
    
    func isLogged(userCompletionHandler: @escaping (User?) -> Void) {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil{
                userCompletionHandler(user)
            }else{
                userCompletionHandler(nil)
            }
        }
    }
    
    
    func signIn(email : String, password : String, userCompletionHandler: @escaping (Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (auth, error) in
            if let error = error {
                userCompletionHandler(error)
            } else {
                userCompletionHandler(nil)
            }
        }
    }
    
    

    
    
}
