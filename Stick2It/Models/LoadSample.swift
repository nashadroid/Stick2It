//
//  LoadSample.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/4/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

if let savedGoals = UserDefaults.standard.object(forKey: key) as? Data {
    print("found saved object")
    let decoder = JSONDecoder()
    if let loadedGoals = try? decoder.decode([Goal].self, from: savedGoals) {
        print(loadedGoals[0].goalName)
        var GoalData: [Goal] = loadedGoals
    }
}

var GoalData: [Goal] = [Goal(id: UUID().hashValue, goalName: "Default Goal", startTime: "00:00", endTime: "00:00", done: false)]//= load("todaySample.json")

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
