//
//  MealDetail.swift
//  SweetFetch
//
//  Created by Paul Valdes on 8/17/24.
//

import Foundation

struct MealDetail: Decodable, Equatable {
    let name: String
    let imageUrl: String?
    
    var instructions: [String] = []
    var ingredients: [Ingredient] = []
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case instructions = "strInstructions"
        case imageUrl = "strMealThumb"
        
        // Could add `ingredients` to the keys and the decoder if data was going to be persisted
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        
        /* Could add an additional attempt to decode as `[String].self` accounting for `instructions` differences
         when decoding from persisted storage.  */
        if let instructionString = try container.decodeIfPresent(String.self, forKey: .instructions) {
            instructions = instructionString
                .replacingOccurrences(of: "\r", with: "")
                .split(separator: "\n").map { String($0) }
        }
    }
}
