//
//  GetProductsService.swift
//  Huaklito
//
//  Created by Ma. de Lourdes Chaparro Candiani on 13/02/20.
//  Copyright © 2020 sgh. All rights reserved.
//

import UIKit


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
    
    
    func getProductImage(productId: String, userCompletionHandler: @escaping (Data?) -> Void) {
        client.downloadImage(storageFolder: "/productPictures", imageFileName: productId) {data in
            userCompletionHandler(data)
        }
    }
    
}
