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
