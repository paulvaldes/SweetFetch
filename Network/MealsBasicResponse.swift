//
//  MealsBasicResponse.swift
//  SweetFetch
//
//  Created by Paul Valdes on 8/17/24.
//

import Foundation

struct MealsBasicResponse: Decodable {
    let meals: [MealBasic]
}
