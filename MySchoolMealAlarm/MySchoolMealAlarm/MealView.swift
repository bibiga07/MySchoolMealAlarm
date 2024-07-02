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
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @StateObject private var viewModel = MealInfoViewModel()
    
    var backButton: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(colorScheme == .dark ? .white : .black)
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
                
                List(viewModel.meals, id: \.self) { meal in
                    VStack(alignment: .leading) {
                        Text(meal.mealName)
                            .font(.system(size: 15, weight: .bold))
                        Text(meal.dishes.replacingOccurrences(of: "<br/>", with: "\n"))
                            .font(.system(size: 15, weight: .regular))
                    }
                }
                VStack(alignment: .leading) {
                    Text("알러지 정보 ❗️")
                        .font(.system(size: 18, weight: .bold))
                    Text("①난류(가금류), ②우유, ③메밀, ④땅콩, ⑤대두, ⑥밀, ⑦고등어, ⑧게, ⑨새우, ⑩돼지고기, ⑪복숭아, ⑫토마토, ⑬아황산염")
                        .font(.system(size: 18, weight: .thin))
                }
                .padding()
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

