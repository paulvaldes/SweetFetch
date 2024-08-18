//
//  MealBasic.swift
//  SweetFetch
//
//  Created by Paul Valdes on 8/17/24.
//

import Foundation

struct MealBasic: Decodable, Identifiable, Hashable {
    let id: String
    let name: String
    let imageUrl: String?
        
    var imageThumbnailUrl: String? {
        guard let imageUrl else {
            return nil
        }
        return imageUrl + "/preview"
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case imageUrl = "strMealThumb"
    }
}
