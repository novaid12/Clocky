//
//  DateExtension.swift
//  Clocky
//
//  Created by  NovA on 18.11.23.
//

import Foundation

extension Date{
    
    func toString(format: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    var localizedDescription: String {
        return description(with: .current)
    }

}
