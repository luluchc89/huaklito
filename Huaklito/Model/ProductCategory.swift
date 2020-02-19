//
//  ProductCategory.swift
//  Huaklito
//
//  Created by Ma. de Lourdes Chaparro Candiani on 13/02/20.
//  Copyright © 2020 sgh. All rights reserved.
//

import Foundation

enum ProductCategory: String, CaseIterable {
    case fruit
    case vegetables
    case groceries
    case dairyProducts
    case disposableProducts
    
    func getCategoryTitle() -> String {
        switch self {
        case .fruit:
            return "Fruta"
        case .vegetables:
            return "Verdura"
        case .groceries:
            return "Abarrotes"
        case .dairyProducts:
            return "Lacteos"
        case .disposableProducts:
            return "Desechables"
        }
    }
}
