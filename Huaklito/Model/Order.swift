//
//  Order.swift
//  Huaklito
//
//  Created by Ma. de Lourdes Chaparro Candiani on 23/02/20.
//  Copyright © 2020 sgh. All rights reserved.
//

import Foundation

struct Order {
    var orderPlacedAt : Date
    var orderDeliveredAt : Date?
    var totalToPay : Double
    var products : [ProductInKart]?
}
