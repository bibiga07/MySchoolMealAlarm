//
//  SearchView.swift
//  MySchoolMealAlarm
//
//  Created by bibiga on 6/20/24.
//

import SwiftUI

struct SearchView: View {
    let officeofEducation = ["서울특별시교육청", "부산광역시교육청", "대구광역시교육청", "인천광역시교육청", "광주광역시교육청", "대전광역시교육청", "울산광역시교육청", "세종특별자치시교육청", "경기도교육청", "강원도교육청", "충청북도교육청", "충청남도교육청", "전북특별자치도교육청", "전라남도교육청", "경상북도교육청", "경상남도교육청", "제주특별자치도교육청"]
    
    @State var searchSchool: String = ""
    @State var SelEducation: String = "인천광역시교육청"
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("우리 학교의 오늘 급식은?😋")
                    .font(.system(size: 28, weight: .bold))
                Text("교육청과 학교를 선택해주세요!")
                    .font(.system(size: 18, weight: .thin))
            }
            
            Spacer()
                .frame(height:30)
            
            Picker("교육청 선택", selection: $SelEducation) {
                ForEach(officeofEducation, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.inline)
            .frame(width:320)
            
            TextField("학교를 입력해주세요!", text: $searchSchool)
                .padding()
                .frame(width:320,height:30)
            
            Rectangle()
                .frame(width:300,height: 1)
            
            Spacer()
                .frame(height:50)
            
            Button {
                
            } label: {
                Rectangle()
                    .frame(width:330,height:50)
                    .foregroundColor(.black)
                    .cornerRadius(15)
                    .overlay(
                        Text("검색")
                            .foregroundColor(.white)
                    )
            }
        }
    }
}

#Preview {
    SearchView()
}
