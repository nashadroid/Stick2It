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

struct Goal: Hashable {
    var id = UUID()
    var goalName: String = "DefaultGoal"
    var done: Bool = false
    
    mutating func updateDone(){
        self.done = true
    }
    
}

