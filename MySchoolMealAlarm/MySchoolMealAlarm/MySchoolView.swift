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
    var body: some View {
        VStack(alignment: .leading) {
            Text("나의 학교는 ?")
                .font(.system(size: 28, weight: .bold))
                .frame(width: 310,height:10, alignment: .leading)
            
            Text("\(selectedEducation), \(searchSchool)")
                .font(.system(size: 16, weight: .regular))
                .frame(width: 310, height: 30, alignment: .leading)
        }
        .onAppear {
            if let savedEducation = UserDefaults.standard.string(forKey: "selectedEducation"),
               let savedSchool = UserDefaults.standard.string(forKey: "searchSchool") {
                selectedEducation = savedEducation
                searchSchool = savedSchool
            }
        }
    }
}

#Preview {
    MySchoolView()
}
