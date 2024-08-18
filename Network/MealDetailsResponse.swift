//
//  MealDetailsResponse.swift
//  SweetFetch
//
//  Created by Paul Valdes on 8/17/24.
//

import Foundation

struct MealDetailsResponse: Decodable {
    let details: MealDetail
    
    enum CodingKeys: CodingKey {
        case meals
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard var meal = try container.decode([MealDetail].self, forKey: .meals).first,
              let rawValues = try container.decode([[String: String?]].self, forKey: .meals).first else {
            throw NetworkError.invalidData("Could not decode data")
        }
        
        let ingredientValues: [Int: String] = Self.extractNumberedValues(from: rawValues, prefix: "strIngredient")
        let measurementValues: [Int: String] = Self.extractNumberedValues(from: rawValues, prefix: "strMeasure")
        var ingredients: [Ingredient] = []
        
        for (key, ingredient) in ingredientValues.sorted(by: { $0.key < $1.key }) {
            ingredients.append(Ingredient(name: ingredient, measurement: measurementValues[key]))
        }
            
        meal.ingredients = ingredients
        details = meal
    }
    
    private static func extractNumberedValues(from rawValues: [String: String?], prefix: String) -> [Int: String] {
        var numberedValues: [Int: String] = [:]
        
        for (key, value) in rawValues.filter({ $0.key.hasPrefix(prefix) }) {
            if let value,
                !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                let index = Int(key.trimmingPrefix(prefix)) {
                numberedValues[index] = value
            }
        }
        
        return numberedValues
    }
}
