//
//  Date+Extension.swift
//  SacrenaChat
//
//  Created by 2674143 on 17/09/24.
//

import Foundation

extension Date {
    func to12HourClockFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: self)
    }
}
