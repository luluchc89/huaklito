//
//  FirebaseClient.swift
//  Huaklito
//
//  Created by Ma. de Lourdes Chaparro Candiani on 16/02/20.
//  Copyright © 2020 sgh. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class FirebaseClient<T> {
    
    var ref: DocumentReference!
    var getRef: Firestore!
    var storageReference: StorageReference!
    
    
    init() {
        getRef = Firestore.firestore()
        storageReference = Storage.storage().reference()
    }
    
    
    func getFirebaseCollection(collectionName: FirebaseCollection, userCompletionHandler: @escaping ([T]) -> Void) {
        var collectionObjects = [T]()
        getRef.collection(collectionName.rawValue).addSnapshotListener { (querySnapshot, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }else{
                for document in querySnapshot!.documents{
                    let firebaseObject = self.createObjectFromDocument(document: document, collection: collectionName)
                    collectionObjects.append(firebaseObject)
                }
                userCompletionHandler(collectionObjects)
            }
        }
    }
    
    func createObjectFromDocument(document: QueryDocumentSnapshot, collection: FirebaseCollection) -> T {
        switch collection {
        case .fruit, .vegetables, .dairyProducts, .disposableProducts, .groceries:
            let id = document.documentID
            let values = document.data()
            let name = values["name"] as? String ?? "producto"
            let unit = values["unit"] as? String ?? "unidad"
            let price = values["price"] as? Double ?? 0
            let product = Product(id: id, name: name, unit: unit, price: price)
            return product as! T
        }
        
    }
    
    
    
}
