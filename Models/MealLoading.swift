//
//  MealLoading.swift
//  SweetFetch
//
//  Created by Paul Valdes on 8/17/24.
//

import Foundation

protocol MealLoading {
    static func fetchAll(_ category: MealCategory) async throws -> [MealBasic]
    static func fetchDetails(for mealId: String) async throws -> MealDetail
}
