//
//  MealDetailView.swift
//  SweetFetch
//
//  Created by Paul Valdes on 8/16/24.
//

import SwiftUI

struct MealDetailView: View {
    @State private var viewModel: MealDetailViewModel
    @State private var showImage: MealImage?
    
    init(viewModel: MealDetailViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                ProgressView("Fetching details...")
                
            case .failed(let error):
                Text("Oops!\nSomething went wrong. Please try again later.\n [\(error.localizedDescription)]")
                
            case .loaded(let meal):
                ScrollView {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(viewModel.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 6)
                        
                        if let imageUrl = meal.imageUrl {
                            AsyncImage(url: URL(string: imageUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .onTapGesture {
                                        showImage = MealImage(id: imageUrl, image: image)
                                    }
                                    .fullScreenCover(item: $showImage) { selection in
                                        ZStack {
                                            // Could add pinch to zoom for fullscreen image
                                            selection.image
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(.rect(cornerRadius: 16))
                                                .onTapGesture {
                                                    showImage = nil
                                                }
                                        }
                                        .presentationBackground {
                                            Color.black
                                                .opacity(0.5)
                                                .onTapGesture {
                                                    showImage = nil
                                                }
                                        }
                                    }
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(maxHeight: 150)
                            .clipShape(.rect(cornerRadius: 16))
                            .padding(.vertical, 12)
                        }
                                                
                        MealDetailSection(title: "Ingredients") {
                            VStack(alignment: .leading) {
                                ForEach(meal.ingredients) { ingredient in
                                    HStack {
                                        Text(ingredient.formattedValue)
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .padding(.bottom)
                        
                        Divider()
                        
                        MealDetailSection(title: "Instructions") {
                            ForEach(meal.instructions, id: \.self) { instruction in
                                Text(instruction)
                                    .foregroundStyle(.primary)
                                    .padding(.vertical, 4)
                            }
                        }
                        .padding(.bottom, 32)
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: .bottom)
        .background {
            Color.gray
                .opacity(0.1)
                .ignoresSafeArea()
        }
        .task {
            await viewModel.load()
        }
    }
}

extension MealDetailView {
    init(meal: MealBasic) {
        self.init(viewModel: MealDetailViewModel(meal: meal))
    }
}

#Preview {
    MealDetailView(viewModel: MealDetailViewModel(meal: MealBasic(id: "123", name: "Sample", imageUrl: "123")))
}
