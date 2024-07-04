//
//  LocalNotification.swift
//  GoTrip - Planner
//
//  Created by Владислав Соколов on 03.07.2024.
//

import Foundation

struct LocalNotification {
    internal init(identifier: String,
                  title: String,
                  body: String,
                  timeInterval: Double,
                  repeats: Bool) {
        self.identifier = identifier
        self.scheduleType = .time
        self.title = title
        self.body = body
        self.timeInterval = timeInterval
        self.dateComponents = nil
        self.repeats = repeats
    }
    
    internal init(identifier: String,
                  title: String,
                  body: String,
                  dateComponents: DateComponents,
                  repeats: Bool) {
        self.identifier = identifier
        self.scheduleType = .calendar
        self.title = title
        self.body = body
        self.timeInterval = nil
        self.dateComponents = dateComponents
        self.repeats = repeats
    }
    
    enum ScheduleType {
        case time, calendar
    }
    
    var identifier: String
    var scheduleType: ScheduleType
    var title: String
    var body: String
    var subtitle: String?
    var bundleImageName: String?
    var timeInterval: Double?
    var dateComponents: DateComponents?
    var repeats: Bool
}

