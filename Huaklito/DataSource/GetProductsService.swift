//
//  GetProductsService.swift
//  Huaklito
//
//  Created by Ma. de Lourdes Chaparro Candiani on 13/02/20.
//  Copyright © 2020 sgh. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class GetProductsService {
    
    var ref: DocumentReference!
    var getRef: Firestore!
    var storageReference: StorageReference!
    
    
    init() {
        getRef = Firestore.firestore()
        storageReference = Storage.storage().reference()
    }
    
    func getFruits(userCompletionHandler: @escaping ([Product]) -> Void) {
        var fruits = [Product]()
        getRef.collection(ProductCategory.fruit.rawValue).addSnapshotListener { (querySnapshot, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }else{
                for document in querySnapshot!.documents{
                    let id = document.documentID
                    let values = document.data()
                    let name = values["name"] as? String ?? "producto"
                    let unit = values["unit"] as? String ?? "unidad"
                    let price = values["price"] as? Double ?? 0
                    let fruit = Product(id: id, name: name, unit: unit, price: price)
                    fruits.append(fruit)
                }
                userCompletionHandler(fruits)
            }
        }
    }
}
