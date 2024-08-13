//
//  TabbarView.swift
//  MySchoolMealAlarm
//
//  Created by bibiga on 8/12/24.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView {
            MySchoolView()
                .tabItem {
                    Image(systemName: "person")
                    Text("나의 학교")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("학교 검색")
                }
        }
        .accentColor(Color(.black))
    }
}

#Preview {
    TabbarView()
}
