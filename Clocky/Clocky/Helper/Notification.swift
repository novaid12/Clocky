//
//  Notification.swift
//  Clocky
//
//  Created by  NovA on 18.11.23.
//

import Foundation
import NotificationCenter
import AVFoundation


class UserNotification{
    
    static let shared = UserNotification()
    
    let current = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()
    
    func addNotificationRequest(alarm: AlarmInfo) {
        content.title = "Clocky"
        content.subtitle = "Wake up, Sleepyhead!"
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("bell.mp3"))
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: alarm.date)
        let minute = calendar.component(.minute, from: alarm.date)
        
        var dateComponents = DateComponents()
        dateComponents.calendar?.locale = Locale(identifier: "ru")
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        if alarm.selectDays.isEmpty {
            triggerRequest(dateComponents: dateComponents, alarm: alarm, isRepeat: false)
        } else {
            let weekdays = alarm.selectDays.map { $0.componentWeekday }
            print(alarm.selectDays)
            weekdays.forEach { weekDay in
                dateComponents.weekday = weekDay
                triggerRequest(dateComponents: dateComponents, alarm: alarm)
            }
        }
    }
    
    func triggerRequest(dateComponents: DateComponents, alarm: AlarmInfo, isRepeat: Bool = true) {
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isRepeat)
        print(dateComponents)
        let request = UNNotificationRequest(identifier: alarm.id.uuidString, content: content, trigger: trigger)
        current.add(request) { error in
            if(error == nil){
                print("successfully")
            }else{
                print("error")
            }
        }
    }

}
