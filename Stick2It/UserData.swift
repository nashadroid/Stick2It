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
    
    func saveData(){
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(self.userGoals) {
            UserDefaults.standard.set(data, forKey: "Usergoals")
        }
        
        let str = "Test Message"
        let url = path.appendingPathComponent("goals.json")
        
        print(url)

        do {
            try str.write(to: url, atomically: true, encoding: .utf8)
            let input = try String(contentsOf: url)
            print(input)
        } catch {
            print(error.localizedDescription)
        }
        
        //let fileManager = FileManager.default
        
    }
    
    func loadData( _ key: String){
        print("Attempting to load...")
        if let savedGoals = UserDefaults.standard.object(forKey: key) as? Data {
            print("found saved object")
            let decoder = JSONDecoder()
            if let loadedGoals = try? decoder.decode([Goal].self, from: savedGoals) {
                print(loadedGoals[0].goalName)
                self.userGoals += loadedGoals
            }
        }
        
    }
    
}

