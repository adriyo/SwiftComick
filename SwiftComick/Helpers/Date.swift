//
// Date.swift
// SwiftComick
//
// Created by Adri Driyo on 30/07/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import Foundation

extension Date {
    func transformedDateString() -> String {
        let calendar = Calendar.current
        let now = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
        if calendar.isDateInToday(self) {
            return "Today"
        } else if calendar.isDateInYesterday(self) {
            return "Yesterday"
        } else if let daysAgo = calendar.dateComponents([.day], from: self, to: now).day, daysAgo < 7 {
            return "\(daysAgo) day\(daysAgo == 1 ? "" : "s") ago"
        } else if let weeksAgo = calendar.dateComponents([.weekOfYear], from: self, to: now).weekOfYear, weeksAgo >= 1 {
            return "\(weeksAgo) week\(weeksAgo == 1 ? "" : "s") ago"
        } else if calendar.component(.year, from: self) == calendar.component(.year, from: now) {
            return DateFormatter.localizedString(from: self, dateStyle: .long, timeStyle: .none)
        } else {
            return DateFormatter.localizedString(from: self, dateStyle: .long, timeStyle: .none)
        }
    }
    
    func getUploadedDate() -> String {
        return self.transformedDateString()
    }
}

