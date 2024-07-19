//
//  ContentView.swift
//  RecipeFinder
//
//  Created by Antonio Lau on 7/18/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MealViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                NavigationLink(destination: MealDetailView(mealId: meal.idMeal)) {
                    Text(meal.strMeal)
                }
            }
            .navigationTitle("Desserts")
            .task {
                await viewModel.fetchMeals()
            }
        }
    }
}

#Preview {
    ContentView()
}
