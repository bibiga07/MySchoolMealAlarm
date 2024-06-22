//
//  MealView.swift
//  MySchoolMealAlarm
//
//  Created by bibiga on 6/22/24.
//

import SwiftUI

struct MealView: View {
    var schoolCode: String?
    var schoolName: String
    
    @StateObject private var viewModel = MealInfoViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let schoolCode = schoolCode {
                    Text("\(schoolName) 🏫")
                        .font(.system(size: 22, weight: .bold))
                        .padding()
                    
                    List(viewModel.meals) { meal in
                        VStack(alignment: .leading) {
                            Text(meal.schoolName)
                                .font(.headline)
                            Text(meal.mealName)
                                .font(.subheadline)
                            Text(meal.dishes)
                                .font(.body)
                        }
                    }
                    .onAppear {
                        viewModel.fetchData(schoolCode: schoolCode)
                    }
                } else {
                    Text("학교 코드를 찾을 수 없습니다.")
                }
            }
        }
    }
}

#Preview {
    MealView(schoolCode: "7240454", schoolName: "대구소프트웨어마이스터고등학교")
}

