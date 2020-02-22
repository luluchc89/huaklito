//
//  Product.swift
//  Huaklito
//
//  Created by Ma. de Lourdes Chaparro Candiani on 13/02/20.
//  Copyright © 2020 sgh. All rights reserved.
//

import Foundation

struct Product {
    var id: String
    var name: String
    var unit: String
    var price: Double
    
}

struct ProductInKart {
    var product: Product
    var quantity: Int
}
