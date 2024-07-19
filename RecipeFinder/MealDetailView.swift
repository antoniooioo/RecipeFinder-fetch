import SwiftUI

struct MealDetailView: View {
    let mealId: String
    @StateObject private var viewModel = MealViewModel()

    var body: some View {
        ScrollView{
            VStack {
                if let mealDetail = viewModel.selectedMealDetail {
                    Text(mealDetail.strMeal)
                        .font(.title)
                        .padding()
                    if let imageUrl = mealDetail.strMealThumb,
                       let url = URL(string: imageUrl) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 200)
                    }
                    Text(mealDetail.strInstructions)
                        .padding()
                    
                    // Display ingredients and measurements dynamically
                    VStack(alignment: .leading) {
                        ForEach(Array(zip(mealDetail.ingredients, mealDetail.measurements)), id: \.0) { ingredient, measurement in
                            HStack {
                                Text(ingredient)
                                Spacer()
                                Text(measurement)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                } else {
                    ProgressView()
                        .task {
                            await viewModel.fetchMealDetail(id: mealId)
                        }
                }
            }
            .navigationTitle("Meal Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
