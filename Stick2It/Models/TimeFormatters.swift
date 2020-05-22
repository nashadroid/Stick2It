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
