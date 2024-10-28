//
//  Date+.swift
//  35-semi
//
//  Created by 조성민 on 10/17/24.
//

import Foundation

extension Date {
    
    init(year: Int, month: Int, day: Int, hour: Int = 0 , minute: Int = 0, second: Int = 0) {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        
        guard let date = calendar.date(from: dateComponents) else {
            self = Date()
            return
        }
        
        self = date
    }
    
}
