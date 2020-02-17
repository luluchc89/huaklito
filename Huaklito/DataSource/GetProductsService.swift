//
//  GetProductsService.swift
//  Huaklito
//
//  Created by Ma. de Lourdes Chaparro Candiani on 13/02/20.
//  Copyright © 2020 sgh. All rights reserved.
//

import Foundation


class GetProductsService {
    
   let client = FirebaseClient<Product>()
    
    
    func getProducts(userCompletionHandler: @escaping ([[Product]]) -> Void) {
        var products : [[Product]] = []
        let dispatchGroup = DispatchGroup()
        let categories : [String] = ProductCategory.allCases.map { $0.rawValue }
        for category in categories{
            dispatchGroup.enter()
            let collection = FirebaseCollection(rawValue: category)
            client.getFirebaseCollection(collectionName: collection!) { data in
                products.append(data)
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: DispatchQueue.main, execute: {
            userCompletionHandler(products)
        })
        
    }
    

    func getFruits(userCompletionHandler: @escaping ([Product]) -> Void) {
        client.getFirebaseCollection(collectionName: .fruit) { data in
            userCompletionHandler(data)
        }
    }
    
}
