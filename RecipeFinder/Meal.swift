//
//  Meal.swift
//  RecipeFinder
//
//  Created by Antonio Lau on 7/18/24.
//

import Foundation

struct Meal: Identifiable, Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String?

    var id: String { idMeal }
}

struct MealDetail: Codable {
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String?
    let ingredients: [String]
    let measurements: [String]

    enum CodingKeys: String, CodingKey {
        case strMeal, strInstructions, strMealThumb
    }

    // Custom initializer to parse dynamic keys
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decodeIfPresent(String.self, forKey: .strMealThumb)

        // Initialize arrays
        var ingredients: [String] = []
        var measurements: [String] = []

        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        for key in dynamicContainer.allKeys {
            if key.stringValue.hasPrefix("strIngredient"),
               let value = try dynamicContainer.decodeIfPresent(String.self, forKey: key),
               !value.isEmpty {
                ingredients.append(value)
            }
            if key.stringValue.hasPrefix("strMeasure"),
               let value = try dynamicContainer.decodeIfPresent(String.self, forKey: key),
               !value.isEmpty {
                measurements.append(value)
            }
        }
        self.ingredients = ingredients
        self.measurements = measurements
    }

    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
}
