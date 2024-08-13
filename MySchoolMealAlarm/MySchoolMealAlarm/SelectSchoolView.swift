//
//  SelectSchoolView.swift
//  MySchoolMealAlarm
//
//  Created by bibiga on 8/12/24.
//

import SwiftUI

struct SelectSchoolView: View {
    let officeofEducation = [
        "서울특별시교육청", "부산광역시교육청", "대구광역시교육청", "인천광역시교육청",
        "광주광역시교육청", "대전광역시교육청", "울산광역시교육청", "세종특별자치시교육청",
        "경기도교육청", "강원도교육청", "충청북도교육청", "충청남도교육청",
        "전북특별자치도교육청", "전라남도교육청", "경상북도교육청", "경상남도교육청",
        "제주특별자치도교육청"
    ]
    
    @State private var selectedEducation: String = "인천광역시교육청"
    @State private var searchSchool: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 30) {
            Text("본인의 학교를 입력해주세요 !")
                .font(.system(size: 28, weight: .bold))
            
            Picker("교육청 선택", selection: $selectedEducation) {
                ForEach(officeofEducation, id: \.self) { education in
                    Text(education)
                        .tag(education)
                }
            }
            .pickerStyle(.inline)
            .frame(width: 320, height: 140)
            
            VStack {
                TextField("학교를 입력해주세요!", text: $searchSchool)
                    .padding()
                    .frame(width: 320, height: 30)
                
                Rectangle()
                    .frame(width: 300, height: 1)
            }
            
            Button(action: {
                if searchSchool.isEmpty {
                    alertMessage = "학교를 올바르게 입력해주세요!"
                    showingAlert = true
                } else {
                    saveSchoolInfo()
                }
            }) {
                Rectangle()
                    .frame(width: 330, height: 50)
                    .foregroundColor(.black)
                    .cornerRadius(15)
                    .overlay(
                        Text("저장")
                            .foregroundColor(.white)
                    )
            }
            .padding()
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertMessage), dismissButton: .default(Text("확인")))
            }
        }
    }
    
    private func saveSchoolInfo() {
        UserDefaults.standard.set(selectedEducation, forKey: "selectedEducation")
        UserDefaults.standard.set(searchSchool, forKey: "searchSchool")
        alertMessage = "학교 정보가 성공적으로 저장되었습니다."
        showingAlert = true
    }
}

#Preview {
    SelectSchoolView()
}

