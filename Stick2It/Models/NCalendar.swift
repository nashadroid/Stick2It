//
//  NCalendar.swift
//  Stick2It
//
//  Created by Nashad Rahman on 7/29/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct NCalendar: Hashable, Codable, Identifiable {
    
    var id: Int
    var calendarName: String
    var enabled: Bool = false
    
}
