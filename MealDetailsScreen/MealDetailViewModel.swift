//
//  MealDetailViewModel.swift
//  SweetFetch
//
//  Created by Paul Valdes on 8/16/24.
//

import SwiftUI

@Observable
class MealDetailViewModel {
    private(set) var state: LoadingState<MealDetail> = .loading
    
    let title: String
    
    private let meal: MealBasic
    private let loader: MealLoading.Type

    init(meal: MealBasic, loader: MealLoading.Type = MealLoader.self) {
        self.meal = meal
        self.loader = loader
        title = meal.name
    }

    func load() async {
        await MainActor.run {
            state = .loading
        }

        do {
            let meal = try await loader.fetchDetails(for: meal.id)
            await MainActor.run {
                state = .loaded(meal)
            }
        } catch {
            await MainActor.run {
                state = .failed(error)
            }
        }
    }
}
