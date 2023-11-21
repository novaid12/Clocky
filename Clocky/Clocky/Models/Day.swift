//
//  Day.swift
//  Clocky
//
//  Created by  NovA on 18.11.23.
//

import Foundation

enum Day: Int, Codable, CaseIterable {
    case  Mon, Tue, Wed, Thu, Fri, Sat, Sun

         var dayString: String
    {
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
            case .Sun: return 1
            case .Mon: return 2
            case .Tue: return 3
            case .Wed: return 4
            case .Thu: return 5
            case .Fri: return 6
            case .Sat: return 7
            
        }
    }
}
