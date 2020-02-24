//
//  User.swift
//  Huaklito
//
//  Created by Ma. de Lourdes Chaparro Candiani on 23/02/20.
//  Copyright © 2020 sgh. All rights reserved.
//

import Foundation

struct User {
    var id : String?
    var email : String
    var deliveryAddress : String
    var orders : [Order]?
}
