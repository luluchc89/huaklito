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
    
    let formatter = DateFormatter()
    
    
    init() {
        getRef = Firestore.firestore()
        storageReference = Storage.storage().reference()
        
        formatter.dateStyle = .short
    }
    
    
    func getCollection(collectionName: DataCollection, userCompletionHandler: @escaping ([T]) -> Void) {
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
    
    //Insert document into Firebase Collection without custom id
    func insertToCollection(collectionName: DataCollection, objectToInsert: T, userCompletionHandler: @escaping (Error?) -> Void) {
        let dataToInsert = createDocumentDataFromObject(object: objectToInsert, collection: collectionName)
        ref = getRef.collection(collectionName.rawValue).addDocument(data: dataToInsert, completion: { error in
            if let error = error{
                userCompletionHandler(error)
            } else {
                userCompletionHandler(nil)
            }
        })

    }
    
    //Insert document into Firebase Collection with custom id
    func insertToCollection(collectionName: DataCollection, id: String, objectToInsert: T, userCompletionHandler: @escaping (Error?) -> Void) {
        let dataToInsert = createDocumentDataFromObject(object: objectToInsert, collection: collectionName)
        getRef.collection(collectionName.rawValue).document(id).setData(dataToInsert) { error in
            if let error = error{
                userCompletionHandler(error)
            } else {
                userCompletionHandler(nil)
            }
        }
    }
    
    func insertToCollectionWithinDocument(rootCollection: DataCollection, document: String, innerCollection: DataCollection, objectToInsert: T, userCompletionHandler: @escaping (Error?) -> Void) {
        let dataToInsert = createDocumentDataFromObject(object: objectToInsert, collection: innerCollection)
        ref = getRef.collection(rootCollection.rawValue).document(document).collection(innerCollection.rawValue).addDocument(data: dataToInsert, completion: { error in
            if let error = error{
                userCompletionHandler(error)
            } else {
                userCompletionHandler(nil)
            }
        })
    }
    
    //Method that creates swift object from Firebase document data
    func createObjectFromDocument(document: QueryDocumentSnapshot, collection: DataCollection) -> T {
        let id = document.documentID
        let values = document.data()
        switch collection {
        case .fruit, .vegetables, .dairyProducts, .disposableProducts, .groceries:
            let name = values["name"] as? String ?? "producto"
            let unit = values["unit"] as? String ?? "unidad"
            let price = values["price"] as? Double ?? 0
            let product = Product(id: id, name: name, unit: unit, price: price)
            return product as! T
        case .users:
            let email = values["email"] as? String ?? "email"
            let deliveryAddress = values["deliveryAddress"] as? String ?? "address"
            let user = User(id: id, email: email, deliveryAddress: deliveryAddress)
            return user as! T
        case .orders:
            let orderPlacedAt = values["orderPlacedAt"] as? Date ?? Date()
            let orderDeliveredAt = values["orderDeliveredAt"] as? Date ?? Date()
            let totalToPay = values["totalToPay"] as? Double ?? 0.0
            let order = Order(orderPlacedAt: orderPlacedAt, orderDeliveredAt: orderDeliveredAt, totalToPay: totalToPay)
            return order as! T
        }
    
    }
    
    
    //Method that converts swift object into Data to create Firebase document
    func createDocumentDataFromObject(object: T, collection: DataCollection) -> [String:Any] {
        var documentData : [String : Any]
        switch collection {
        case .fruit, .vegetables, .dairyProducts, .disposableProducts, .groceries:
            let product = object as! Product
            documentData = ["name": product.id, "unit": product.unit, "price": product.price]
        case .users:
            let user = object as! User
            documentData = ["email": user.email, "deliveryAddress": user.deliveryAddress]
        case .orders:
            let order = object as! Order
            let deliveredAt = formatter.string(from: order.orderDeliveredAt ?? Date())
            documentData = ["orderPlacedAt": formatter.string(from: order.orderPlacedAt), "orderDeliveredAt": deliveredAt , "totalToPay": order.totalToPay]
        }
        return documentData
        
    }
    
    
    func downloadImage(storageFolder: String, imageFileName: String, userCompletionHandler: @escaping (Data?) -> Void) {
        let userImageRef = storageReference.child(storageFolder).child(imageFileName + ".jpg")
        
        userImageRef.getData(maxSize: 1*1024*1024, completion: { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                userCompletionHandler(data)
            }
        })
    }
    
    
    
}
