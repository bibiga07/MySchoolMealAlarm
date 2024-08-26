//
//  SearchView.swift
//  MySchoolMealAlarm
//
//  Created by bibiga on 6/20/24.
//

import SwiftUI

struct SearchView: View {
    let officeofEducation = [
        "서울특별시교육청", "부산광역시교육청", "대구광역시교육청", "인천광역시교육청",
        "광주광역시교육청", "대전광역시교육청", "울산광역시교육청", "세종특별자치시교육청",
        "경기도교육청", "강원도교육청", "충청북도교육청", "충청남도교육청",
        "전북특별자치도교육청", "전라남도교육청", "경상북도교육청", "경상남도교육청",
        "제주특별자치도교육청"
    ]
    @State private var searchSchool: String = ""
    @State private var selectedEducation: String = "인천광역시교육청"
    @State private var educationCode: String = ""
    @State private var schoolCode: String? = nil
    @State private var navigateToMealView = false
    
    @State private var SchoolAlert = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("우리 학교의 오늘 급식은?😋")
                        .font(.system(size: 28, weight: .bold))
                    Text("교육청과 학교를 선택해주세요!")
                        .font(.system(size: 18, weight: .thin))
                }
                
                Spacer().frame(height: 30)
                
                Picker("교육청 선택", selection: $selectedEducation) {
                    ForEach(officeofEducation, id: \.self) { education in
                        Text(education)
                            .tag(education)
                    }
                }
                .pickerStyle(.inline)
                .frame(width: 320)
                
                // 교육청 선택 변경 시 학교 데이터 파일 이름 설정
                .onChange(of: selectedEducation) { newValue in
                    educationCode = getEducationCode(newValue)
                }
                
                TextField("학교를 입력해주세요!", text: $searchSchool)
                    .padding()
                    .frame(width: 320, height: 30)
                
                Rectangle()
                    .frame(width: 300, height: 1)
                
                Spacer().frame(height: 50)
                
                Button(action: {
                    if let code = searchSchoolCode(educationCode: educationCode, schoolName: searchSchool) {
                        schoolCode = code
                        navigateToMealView = true
                    } else {
                        self.SchoolAlert.toggle()
                    }
                }) {
                    Rectangle()
                        .frame(width: 330, height: 50)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .cornerRadius(15)
                        .overlay(
                            Text("검색")
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                        )
                }
                .alert(isPresented: $SchoolAlert) {
                    Alert(title: Text("학교를 올바르게 입력해주세요 !"), message: nil,
                          dismissButton: .default(Text("확인")))
                }
                NavigationLink(
                    destination: MealView(schoolCode: schoolCode, schoolName: searchSchool, educationCode: educationCode),
                    isActive: $navigateToMealView
                ) {
                    EmptyView()
                }
            }
        }
    }
    
    func getEducationCode(_ education: String) -> String {
        switch education {
        case "서울특별시교육청":
            return "B10"
        case "부산광역시교육청":
            return "C10"
        case "대구광역시교육청":
            return "D10"
        case "인천광역시교육청":
            return "E10"
        case "광주광역시교육청":
            return "F10"
        case "대전광역시교육청":
            return "G10"
        case "울산광역시교육청":
            return "H10"
        case "세종특별자치시교육청":
            return "I10"
        case "경기도교육청":
            return "J10"
        case "강원도교육청":
            return "K10"
        case "충청북도교육청":
            return "M10"
        case "충청남도교육청":
            return "N10"
        case "전북특별자치도교육청":
            return "P10"
        case "전라남도교육청":
            return "Q10"
        case "경상북도교육청":
            return "R10"
        case "경상남도교육청":
            return "S10"
        case "제주특별자치도교육청":
            return "T10"
        default:
            return ""
        }
    }
    
    func loadSchoolData(from file: String) -> [String: String] {
        var schoolData = [String: String]()
        if let filepath = Bundle.main.path(forResource: "\(educationCode)_education", ofType: "csv") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let lines = contents.components(separatedBy: .newlines)
                for line in lines {
                    let data = line.components(separatedBy: ",")
                    if data.count == 2 {
                        let schoolCode = data[0].trimmingCharacters(in: .whitespacesAndNewlines)
                        let schoolName = data[1].trimmingCharacters(in: .whitespacesAndNewlines)
                        schoolData[schoolName] = schoolCode
                    }
                }
            } catch {
                print("CSV 파일 로드 오류: \(error.localizedDescription)")
            }
        } else {
            print("파일을 찾을 수 없음")
        }
        return schoolData
    }
    
    func searchSchoolCode(educationCode: String, schoolName: String) -> String? {
        let filename = "\(educationCode.uppercased())_education.csv"
        let schoolData = loadSchoolData(from: filename)
        return schoolData[schoolName]
    }
}

#Preview {
    SearchView()
}
