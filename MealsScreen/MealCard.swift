//
//  MealCard.swift
//  SweetFetch
//
//  Created by Paul Valdes on 8/17/24.
//

import SwiftUI

struct MealCard: View {
    let meal: MealBasic
    
    var body: some View {
        HStack {
            if let imageUrl = meal.imageThumbnailUrl {
                // Could add image caching to reduce reloads while scrolling up and down
                AsyncImage(url: URL(string: imageUrl), transaction: Transaction(animation: .default)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                        
                    case .failure:
                        Image(systemName: "popcorn")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color.secondary.opacity(0.3))
                        
                    default:
                        ProgressView()
                    }
                }
                .frame(maxWidth: 75, maxHeight: 75)
            }
            
            Text(meal.name)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(Color.primary)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(Color.primary)
                .padding()
        }
        .frame(maxWidth: .infinity, minHeight: 75)
        .background {
            Color.gray.opacity(0.15)
        }
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    MealCard(meal: MealBasic(id: "52893", name: "Apple & Blackberry Crumble", imageUrl: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg"))
        .padding()
}
