//
//  MealCategory.swift
//  SweetFetch
//
//  Created by Paul Valdes on 8/17/24.
//

import Foundation

enum MealCategory {
    case dessert
    
    var urlValue: String {
        switch self {
        case .dessert:
            return name
        }
    }
    
    var name: String {
        switch self {
        case .dessert:
            return "Dessert"
        }
    }
}
