//
//  MealViewModel.swift
//  RecipeFinder
//
//  Created by Antonio Lau on 7/18/24.
//

import Foundation

@MainActor
class MealViewModel: ObservableObject{
    @Published var meals: [Meal] = []
    @Published var selectedMealDetail: MealDetail?

    func fetchMeals() async {
        do{
            meals = try await NetworkManager.shared.fetchMeals()
        } catch{
            print("Failed to fetch meals: \(error)")
        }
    }

    func fetchMealDetail(id: String) async {
        do{
            selectedMealDetail = try await NetworkManager.shared.fetchMealDetail(id: id)
        }catch{
            print("Failed to fetch meal detail: \(error)")
        }
    }
}
