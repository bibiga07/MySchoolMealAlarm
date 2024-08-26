//
//  MySchoolMealAlarmApp.swift
//  MySchoolMealAlarm
//
//  Created by bibiga on 6/19/24.
//

import SwiftUI
import UserNotifications

@main
struct MySchoolMealAlarmApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            TabbarView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        requestNotificationPermissionAndSchedule()
        return true
    }
    
    private func requestNotificationPermissionAndSchedule() {
        let center = UNUserNotificationCenter.current()
        
        // 알림 권한 요청
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                self.scheduleDailyNotification()
            } else {
                print("알림 권한이 거부되었습니다.")
            }
        }
    }
    
    private func scheduleDailyNotification() {
        let center = UNUserNotificationCenter.current()
        
        // 알림 콘텐츠 설정
        let content = UNMutableNotificationContent()
        content.title = "좋은 아침 이에요 :)"
        content.body = "오늘의 급식을 확인해보세요 !"
        content.sound = UNNotificationSound.default
        
        // 오전 8시로 트리거 설정
        var dateComponents = DateComponents()
        dateComponents.hour = 8
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // 요청 생성 및 알림 센터에 추가
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error = error {
                print("알림 요청 실패: \(error.localizedDescription)")
            }
        }
    }
}
