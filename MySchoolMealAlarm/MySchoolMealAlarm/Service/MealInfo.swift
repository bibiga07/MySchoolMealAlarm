//
//  MealInfo.swift
//  MySchoolMealAlarm
//
//  Created by bibiga on 6/20/24.
//

import Foundation

struct MealInfo: Identifiable {
    let id = UUID()
    let officeCode: String
    let officeName: String
    let schoolCode: String
    let schoolName: String
    let mealCode: String
    let mealName: String
    let mealDate: String
    let dishes: String
}
