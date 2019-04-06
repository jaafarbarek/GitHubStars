//
//  Date+Extension.swift
//  GithubStars
//
//  Created by Jaafar Barek on 4/6/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//

import Foundation

extension Date {
    func getDateString(inThePastDays days:Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = Calendar.current.date(byAdding: .day, value: -days, to: self)!
        let dateString = formatter.string(from: date)
        return dateString
    }
}
