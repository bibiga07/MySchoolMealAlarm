//
//  TabbarView.swift
//  MySchoolMealAlarm
//
//  Created by bibiga on 8/12/24.
//

import SwiftUI

struct TabbarView: View {
    @Environment(\.colorScheme) var colorScheme
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
            SelectSchoolView()
                .tabItem {
                    Image(systemName: "graduationcap")
                    Text("학교 선택")
                }
        }
        .accentColor(colorScheme == .dark ? .white : .black)
    }
}

#Preview {
    TabbarView()
}

