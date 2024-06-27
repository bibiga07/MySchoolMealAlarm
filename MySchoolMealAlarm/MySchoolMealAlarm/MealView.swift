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
    var educationCode: String
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel = MealInfoViewModel()
    
    var backButton: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.black)
        }
    }
    
    var body: some View {
        VStack {
            if let schoolCode = schoolCode {
                HStack {
                    Text("오늘의 날짜는 ? ")
                        .font(.system(size: 18, weight: .regular))
                    Text("\(viewModel.currentDate) 📅")
                        .font(.system(size: 18, weight: .thin))
                }
                
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
                    viewModel.fetchData(schoolCode: schoolCode, educationCode: educationCode)
                }
            } else {
                Text("학교 코드를 찾을 수 없습니다.")
            }
        }
        .navigationBarTitle("\(schoolName) 🏫", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
}

#Preview {
    MealView(schoolCode: "7240454", schoolName: "대구소프트웨어마이스터고등학교", educationCode: "D10")
}
