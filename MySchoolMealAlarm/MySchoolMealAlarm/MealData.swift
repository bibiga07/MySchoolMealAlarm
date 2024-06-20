//
//  MealData.swift
//  MySchoolMealAlarm
//
//  Created by bibiga on 6/20/24.
//

import Foundation

class MealData: NSObject, XMLParserDelegate {
    var currentElement = ""
    var currentOfficeCode = ""
    var currentOfficeName = ""
    var currentSchoolCode = ""
    var currentSchoolName = ""
    var currentMealCode = ""
    var currentMealName = ""
    var currentMealDate = ""
    var currentDishes = ""
    
    var mealServiceDietInfos: [MealInfo] = []
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "ATPT_OFCDC_SC_CODE":
            currentOfficeCode += string
        case "ATPT_OFCDC_SC_NM":
            currentOfficeName += string
        case "SD_SCHUL_CODE":
            currentSchoolCode += string
        case "SCHUL_NM":
            currentSchoolName += string
        case "MMEAL_SC_CODE":
            currentMealCode += string
        case "MMEAL_SC_NM":
            currentMealName += string
        case "MLSV_YMD":
            currentMealDate += string
        case "DDISH_NM":
            currentDishes += string
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "row" {
            let info = MealInfo(
                officeCode: currentOfficeCode,
                officeName: currentOfficeName,
                schoolCode: currentSchoolCode,
                schoolName: currentSchoolName,
                mealCode: currentMealCode,
                mealName: currentMealName,
                mealDate: currentMealDate,
                dishes: currentDishes
            )
            mealServiceDietInfos.append(info)
            currentOfficeCode = ""
            currentOfficeName = ""
            currentSchoolCode = ""
            currentSchoolName = ""
            currentMealCode = ""
            currentMealName = ""
            currentMealDate = ""
            currentDishes = ""
        }
    }
}
