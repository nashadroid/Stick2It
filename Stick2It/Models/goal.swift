//
//  goal.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/4/20.
//  Copyright © 2020 NashApps. All rights reserved.
//
//  struct used to make all goals

import SwiftUI

struct Goal: Hashable, Codable, Identifiable {
    
    var id: Int
    var goalName: String
    var startTime: Date
    var endTime: Date
    var scheduled: Bool = true
    var project: String = "none"
    var done: Bool
}

