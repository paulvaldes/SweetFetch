//
//  MealDetailSection.swift
//  SweetFetch
//
//  Created by Paul Valdes on 8/17/24.
//

import SwiftUI

struct MealDetailSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title)
                .foregroundStyle(.secondary)
            
            content
        }
    }
}

#Preview {
    MealDetailSection(title: "Example") {
        ForEach(["object 1", "object 2", "object 3"], id: \.self) { value in
            Text(value)
                .foregroundStyle(.primary)
                .padding(.vertical, 4)
        }
    }
}
