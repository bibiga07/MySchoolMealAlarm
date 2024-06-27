//
//  MealInfoViewModel.swift
//  MySchoolMealAlarm
//
//  Created by bibiga on 6/20/24.
//

import Foundation
import Alamofire

class MealInfoViewModel: ObservableObject {
    @Published var meals: [MealInfo] = []
    
    var currentDate: String {
        return getCurrentDate()
    }
    
    func fetchData(schoolCode: String, educationCode: String) {
        let todayDate = getCurrentDate()
        let parameters: [String: String] = [
            "ATPT_OFCDC_SC_CODE": educationCode,
            "SD_SCHUL_CODE": schoolCode,
            "KEY": "\(Storage().niceapiKey)",
            "MLSV_YMD": todayDate
        ]
        
        let url = "https://open.neis.go.kr/hub/mealServiceDietInfo"
        
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let parser = XMLParser(data: data)
                    let parserDelegate = MealData()
                    parser.delegate = parserDelegate
                    if parser.parse() {
                        DispatchQueue.main.async {
                            self.meals = parserDelegate.mealServiceDietInfos
                        }
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
    
    private func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: Date())
    }
}

