//
//  TimeFormatters.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/11/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

func getTimeStringFromDate(_ date: Date) -> String{
    
    let formatter2 = DateFormatter()
    formatter2.timeStyle = .short
    return formatter2.string(from: date)
    
}

func getTimeIntFromDate(_ date: Date) -> Int{
    
    
    let formatter2 = DateFormatter()
    formatter2.dateFormat = "HHmm"
    return Int(formatter2.string(from: date)) ?? 0
    
}


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
    
    
    
    return strToReturn
}

func getPastWeek() -> [Date]{
    var listOfDays: [Date] = []
    for i in -7...0{
        listOfDays += [Calendar.current.date(byAdding: .day, value: i, to: Date()) ?? Date()]
    }
    
    return listOfDays
}
func getLastHour() -> Date {
    if let roundedHours = Calendar.current.date(bySetting: .minute, value: 0, of: Date()){
            return Calendar.current.date(byAdding: .hour, value: -1, to: roundedHours) ?? Date()
    }
    return Date()
}
func getNextHour() -> Date {
    if let roundedHours = Calendar.current.date(bySetting: .minute, value: 0, of: Date()){
        return roundedHours
    }
    return Date()
}

func getYesterday() -> Date {
    return Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
}

func getStringFromDate(date: Date) -> String {
    let formatter1 = DateFormatter()
    formatter1.dateFormat = "YD"
    return formatter1.string(from: date)
}
