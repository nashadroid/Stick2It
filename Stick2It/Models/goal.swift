//
//  goal.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/4/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

//TODO: Change id to customized
//TODO: Try Default Values

struct Goal: Hashable, Codable, Identifiable {
    
    var id: Int
    var goalName: String
    var startTime: Date
    var endTime: Date
    var date: String = "none" //TODO: Delete, it is obsolete
    var project: String = "none"
    var done: Bool
}

