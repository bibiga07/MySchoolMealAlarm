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
    
    func fetchData(schoolCode: String) {
        let parameters: [String: String] = [
            "ATPT_OFCDC_SC_CODE": "D10",
            "SD_SCHUL_CODE": schoolCode,
            "KEY": "\(Storage().niceapiKey)",
            "MLSV_YMD": "20240620"
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
}
