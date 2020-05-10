//
//  LoadSample.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/4/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

var GoalData: [Goal] =  []

//= load("todaySample.json")

func loadSavedGoals() -> [Goal]{
    if let savedGoals = UserDefaults.standard.object(forKey: "Usergoals") as? Data {
        let decoder = JSONDecoder()
        if let loadedGoals = try? decoder.decode([Goal].self, from: savedGoals) {
            GoalData = loadedGoals
            return GoalData
        }
    }
    return []
}

var RoutineData: [Routine] = []

func loadSavedRoutines() -> [Routine]{
    if let savedRoutines = UserDefaults.standard.object(forKey: "UserRoutines") as? Data {
        let decoder = JSONDecoder()
        if let loadedRoutine = try? decoder.decode([Routine].self, from: savedRoutines) {
            RoutineData = loadedRoutine
            return loadedRoutine
        }
    }
    return []
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
