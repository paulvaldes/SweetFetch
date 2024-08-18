//
//  RemoteDataManager.swift
//  SweetFetch
//
//  Created by Paul Valdes on 8/15/24.
//

import Foundation

struct MealLoader: MealLoading {
    static func fetchAll(_ category: MealCategory) async throws -> [MealBasic] {
        let url = try UrlBuilder.mealsUrl(for: category)
        let (data, response) = try await URLSession.shared.data(from: url)
        let httpResponse = response as? HTTPURLResponse

        guard let httpResponse, 200 ..< 300 ~= httpResponse.statusCode else {
            throw NetworkError.responseError("Invalid status received [\(httpResponse?.statusCode ?? -1)]")
        }
        
        return try JSONDecoder().decode(MealsBasicResponse.self, from: data).meals
    }
    
    static func fetchDetails(for mealId: String) async throws -> MealDetail {
        let url = try UrlBuilder.mealDetailUrl(for: mealId)
        let (data, response) = try await URLSession.shared.data(from: url)
        let httpResponse = response as? HTTPURLResponse
        
        guard let httpResponse, 200 ..< 300 ~= httpResponse.statusCode else {
            throw NetworkError.responseError("Invalid status received [\(httpResponse?.statusCode ?? -1)]")
        }
        
        return try JSONDecoder().decode(MealDetailsResponse.self, from: data).details
    }
}

// MARK: API URLs

private extension MealLoader {
    struct UrlBuilder {
        static let baseUrlString = "https://www.themealdb.com/api/json/v1/1/"
        
        static func mealsUrl(for category: MealCategory) throws -> URL {
            let urlString = baseUrlString + "filter.php?c=\(category.urlValue)"
            
            guard let url = URL(string: urlString) else {
                throw NetworkError.invalidUrl("Invalid URL [\(urlString)]")
            }
            
            return url
        }
        
        static func mealDetailUrl(for mealId: String) throws -> URL {
            let urlString = baseUrlString + "lookup.php?i=\(mealId)"
            guard let url = URL(string: urlString) else {
                throw NetworkError.invalidUrl("Invalid URL [\(urlString))]")
            }
            
            return url
        }
    }
}
