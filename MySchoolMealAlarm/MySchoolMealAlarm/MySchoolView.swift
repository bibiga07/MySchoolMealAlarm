//
//  MySchoolView.swift
//  MySchoolMealAlarm
//
//  Created by bibiga on 8/13/24.
//

import SwiftUI

struct MySchoolView: View {
    @State private var selectedEducation: String = ""
    @State private var searchSchool: String = ""
    @State private var schoolCode: String? = nil
    @State private var educationCode: String = ""
    @StateObject private var viewModel = MealInfoViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                if let schoolCode = schoolCode {
                    VStack(alignment: .leading) {
                        Text("오늘 우리 학교 급식은 ?")
                            .font(.system(size: 28, weight: .bold))
                            .frame(width: 300, height: 10, alignment: .leading)
                            .padding(.leading,20)
                        
                        Text("\(selectedEducation) \(searchSchool)")
                            .font(.system(size: 16, weight: .regular))
                            .frame(width: 350, height: 30, alignment: .leading)
                            .padding(.leading,20)
                    }
                    .padding(.top,30)
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
                    .padding(30)
                } else {
                    VStack {
                        Text("학교가 등록 되어 있지 않아요 !")
                            .font(.system(size: 28, weight: .bold))
                        NavigationLink(destination: SelectSchoolView()) {
                            Rectangle()
                                .frame(width:340,height:50)
                                .cornerRadius(10)
                                .foregroundColor(.black)
                                .overlay(
                                    Text("학교 등록하기")
                                        .foregroundColor(.white)
                                )
                        }
                    }
                }
            }
            .onAppear {
                if let savedEducation = UserDefaults.standard.string(forKey: "selectedEducation"),
                   let savedSchool = UserDefaults.standard.string(forKey: "searchSchool") {
                    selectedEducation = savedEducation
                    searchSchool = savedSchool
                    educationCode = getEducationCode(selectedEducation)
                    
                    if let code = searchSchoolCode(educationCode: educationCode, schoolName: searchSchool) {
                        schoolCode = code
                        viewModel.fetchData(schoolCode: schoolCode!, educationCode: educationCode)
                    }
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
    MySchoolView()
}
