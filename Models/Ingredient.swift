//
//  Ingredient.swift
//  SweetFetch
//
//  Created by Paul Valdes on 8/17/24.
//

import Foundation

struct Ingredient: Identifiable, Equatable {
    let id = UUID()
    let name: String
    var measurement: String?
    
    var formattedValue: String {
        var value = ""
        
        if let measurement {
            value = "\(measurement)  "
        }
        
        return value + name
    }
}
