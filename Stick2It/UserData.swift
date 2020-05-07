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
    @Published var userGoals = loadSavedData()
    
    func addData(_ goalName: String, _ startTime: String, _ endTime: String, _ date: String, _ project: String){
        
        let newGoal = Goal(id: UUID().hashValue, goalName: goalName, startTime: startTime, endTime: endTime, date: date, project: project, done: false)
        
        userGoals += [newGoal]
    }
    
    func saveData(){
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self.userGoals) {
            UserDefaults.standard.set(data, forKey: "Usergoals")
        }
    }
    
    func loadData( _ key: String){
        if let savedGoals = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let loadedGoals = try? decoder.decode([Goal].self, from: savedGoals) {
                self.userGoals += loadedGoals
            }
        }
    }
}

