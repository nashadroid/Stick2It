//
//  TimeFormatters.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/11/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

// Gets a string from any date
func getTimeStringFromDate(_ date: Date) -> String{
    
    let formatter2 = DateFormatter()
    formatter2.timeStyle = .short
    return formatter2.string(from: date)
}

// Gets an int from any date object to compare time of day across any day
func getTimeIntFromDate(_ date: Date) -> Int{
    
    let formatter2 = DateFormatter()
    formatter2.dateFormat = "HHmm"
    return Int(formatter2.string(from: date)) ?? 0
}

// Returns a string to represent which says a routine is repeated on
func getShortStringFromRepeatDays(repeatedOn: [Bool]) -> String {
    var strToReturn: String = ""
    
    if repeatedOn[1...5].allSatisfy({$0}){
        if repeatedOn.allSatisfy({$0}){
            return "Everyday"
        }
        else{
            return "Weekdays"
        }
    }
    
    if(repeatedOn[0]){
        strToReturn += "Sun "
    }
    if(repeatedOn[1]){
        strToReturn += "Mon "
    }
    if(repeatedOn[2]){
        strToReturn += "Tue "
    }
    if(repeatedOn[3]){
        strToReturn += "Wed "
    }
    if(repeatedOn[4]){
        strToReturn += "Thu "
    }
    if(repeatedOn[5]){
        strToReturn += "Fri "
    }
    if(repeatedOn[6]){
        strToReturn += "Sat"
    }
    
    if strToReturn != "" {
        return strToReturn
    }
    return "No Days Selected :("
    
}

// Returns a list of Date objects corresponding to the past week
func getPastWeek() -> [Date]{
    var listOfDays: [Date] = []
    for i in -7...0{
        listOfDays += [Calendar.current.date(byAdding: .day, value: i, to: Date()) ?? Date()]
    }
    
    return listOfDays
}
// Returns a list of Date objects corresponding to the next week
func getNextWeek() -> [Date]{
    var listOfDays: [Date] = []
    for i in 0...7{
        listOfDays += [Calendar.current.date(byAdding: .day, value: i, to: Date()) ?? Date()]
    }
    
    return listOfDays
}
// Returns nearest hour as date, to default new goals and routines
func getLastHour() -> Date {
    if let roundedHours = Calendar.current.date(bySetting: .minute, value: 0, of: Date()){
            return Calendar.current.date(byAdding: .hour, value: -1, to: roundedHours) ?? Date()
    }
    return Date()
}

// Returns next hour as date, to default new goals and routines
func getNextHour() -> Date {
    if let roundedHours = Calendar.current.date(bySetting: .minute, value: 0, of: Date()){
        return roundedHours
    }
    return Date()
}

// Returns yesterday's date
func getYesterday() -> Date {
    return Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
}

func getTomorrow() -> Date {
    return Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
}

// Returns string of date
func getStringFromDate(date: Date) -> String {
    let formatter1 = DateFormatter()
    formatter1.dateFormat = "YD"
    return formatter1.string(from: date)
}
func oldestDate() -> Date {
    
    return Calendar.current.date(byAdding: .year, value: -1000, to: Date()) ?? Date()
}
func getDayOfWeek(day: Date) -> String {
    let f = DateFormatter()
    return f.weekdaySymbols[Calendar.current.component(.weekday, from: day) - 1]
}
