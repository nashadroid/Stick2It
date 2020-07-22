//
//  SwiftUIView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/8/20.
//  Copyright © 2020 NashApps. All rights reserved.
//
//  struct used to make all routines

import SwiftUI

struct Routine: Hashable, Codable, Identifiable {
    
    var id: Int
    var routineName: String
    var startTime: Date
    var endTime: Date
    var repeatOn: [Bool] = [false, false, false, false, false, false, false]
    var running: Bool = true
    var project: String = "none"
    
}
