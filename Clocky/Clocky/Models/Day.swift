//
//  Day.swift
//  Clocky
//
//  Created by  NovA on 18.11.23.
//

import Foundation

enum Day: Int, Codable, CaseIterable {
    case Mon = 0, Tue, Wed, Thu, Fri, Sat, Sun

    var dayString: String {
        switch self {
            case .Mon: return "Every Monday"
            case .Tue: return "Every Tuesday"
            case .Wed: return "Every Wednesday"
            case .Thu: return "Every Thursday"
            case .Fri: return "Every Friday"
            case .Sat: return "Every Saturday"
            case .Sun: return "Every Sunday"
        }
    }

    var dayText: String {
        switch self {
            case .Mon: return "Mon"
            case .Tue: return "Tue"
            case .Wed: return "Wed"
            case .Thu: return "Thu"
            case .Fri: return "Fri"
            case .Sat: return "Sat"
            case .Sun: return "Sun"
        }
    }

    var componentWeekday: Int {
        switch self {
            case .Mon: return 1
            case .Tue: return 2
            case .Wed: return 3
            case .Thu: return 4
            case .Fri: return 5
            case .Sat: return 6
            case .Sun: return 7
        }
    }
}
