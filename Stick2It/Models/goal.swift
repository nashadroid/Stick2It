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
    var startTime: String
    var endTime: String
    var date: String = "none"
    var project: String = "none"
    var done: Bool
}

