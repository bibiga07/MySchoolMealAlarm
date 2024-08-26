//
//  Launchs.swift
//  MySchoolMealAlarm
//
//  Created by bibiga on 6/27/24.
//

import SwiftUI

struct Launchs: View {
    var body: some View {
        VStack {
            Image(systemName: "fork.knife")
                .resizable()
                .scaledToFit()
                .frame(height: 128)
                .padding(22)
            Text("나의 급식 알리미")
                .font(.system(size: 30, weight: .bold))
        }
    }
}

#Preview {
    Launchs()
}
