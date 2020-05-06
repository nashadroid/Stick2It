//
//  UserData.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/5/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject  {
    @Published var userGoals = GoalData
    
    func addData(_ goalName: String, _ startTime: String, _ endTime: String){
        
        
        let newGoal = Goal(id: UUID().hashValue, goalName: goalName, startTime: startTime, endTime: endTime, done: false)
        
        userGoals += [newGoal]
        
        
    }
    
}

