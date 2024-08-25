//
//  DateFormat.swift
//  Shared
//
//  Created by 제이콥 on 5/22/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import Foundation

public class DateFormat {
    public static let shared = DateFormat()
    private var formatter = DateFormatter()
    public init() {
        formatter.locale = Locale(identifier: "ko_KR")
    }
    
    func yearMonthString(date: Date) -> String {
        formatter.dateFormat = "yyyyMM"
        let dateString = formatter.string(from: date)
        return dateString
    }
}
