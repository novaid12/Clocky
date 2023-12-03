//
//  Notification.swift
//  Clocky
//
//  Created by  NovA on 18.11.23.
//

import AudioKit
import AVFoundation
import Foundation
import NotificationCenter
import UserNotifications

class UserNotification {
    static let shared = UserNotification()
    let current = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()

    func addNotificationRequest(alarm: AlarmInfo) {
        content.title = "Clocky"
        content.subtitle = "Wake up, Sleepyhead!"
        content.categoryIdentifier = "alarm"

        guard let url = Bundle.main.url(forResource: "JustPretend", withExtension: "mp3") else { return }
        MusicService.exportTrimmedAudio(from: url, from: 20.0, to: 50.0) { [weak self] sound in
            if let trimmedURL = sound {
                print("Trimmed audio file saved at \(trimmedURL)")
                self?.content.title = "Clocky"
                self?.content.subtitle = "Wake up, Sleepyhead!"
                self?.content.categoryIdentifier = "alarm"
                self?.content.sound = UNNotificationSound(named: UNNotificationSoundName(trimmedURL.lastPathComponent))
            } else {
                print("Failed to save trimmed audio file")
            }
        }
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
            if error == nil {
                print("successfully")
            } else {
                print("error")
            }
        }
    }
}


