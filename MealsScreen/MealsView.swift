//
//  MealsView.swift
//  SweetFetch
//
//  Created by Paul Valdes on 8/15/24.
//

import SwiftUI

struct MealsView: View {
    @State private var loadingState: LoadingState<[MealBasic]> = .loading
    @State private var path: [MealBasic] = []
    
    // Could be changed to an @State property to allow for dynamic category selection
    private let category: MealCategory = .dessert
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                switch loadingState {
                case .loading:
                    ProgressView("Fetching...")
                    
                case .failed(let error):
                    Text("Oops! Something went wrong. Please try again later. [\(error.localizedDescription)]")
                    
                case .loaded(let meals):
                    ScrollView {
                        LazyVStack {
                            ForEach(meals) { meal in
                                Button {
                                    path = [meal]
                                } label: {
                                  MealCard(meal: meal)
                                }
                            }
                        }
                        
                        // Spacer to ensure the bottom items of the list can scroll up beyond the bottom safe area
                        Spacer()
                            .frame(minHeight: 32)
                    }
                    .padding(.horizontal)
                    .background {
                        Color.gray
                            .opacity(0.1)
                            .ignoresSafeArea()
                    }
                }
            }
            .navigationDestination(for: MealBasic.self) { selection in
                MealDetailView(meal: selection)
            }
            .navigationTitle(category.name)
        }
        .ignoresSafeArea(edges: .bottom)
        .background {
            Color.gray
                .opacity(0.1)
                .ignoresSafeArea()
        }
        .task {
            await fetchMeals()
        }
    }
    
    private func fetchMeals() async {
        do {
            let meals = try await MealLoader.fetchAll(category)
            loadingState = .loaded(meals.sorted(by: { $0.name < $1.name }))
        } catch {
            loadingState = .failed(error)
        }
    }
}

#Preview {
    MealsView()
}
