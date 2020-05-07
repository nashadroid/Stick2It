//
//  LoadSample.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/4/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

var GoalData: [Goal] =  [Goal(id: 2020, goalName: "Name1", startTime: "00:00", endTime: "00:00", date: "000000", project: "none", done: true)]

//= load("todaySample.json")

func loadSavedData() -> [Goal]{
    if let savedGoals = UserDefaults.standard.object(forKey: "Usergoals") as? Data {
        let decoder = JSONDecoder()
        if let loadedGoals = try? decoder.decode([Goal].self, from: savedGoals) {
            GoalData = loadedGoals
            return GoalData
        }
    }
    return []
//    return [Goal(id: UUID().hashValue, goalName: "DefGoal", startTime: "-", endTime: "-", done: false)]
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
