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
    @Published var userGoals = loadSavedGoals()
    @Published var userRoutines = loadSavedRoutines()
    
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
    
//    func removeGoal(id: Int){
//        ForEach(self.userGoals) {goal in
//            if id == goal.id{
//                GoalBox(goal: goal)
//            }
//        }
//    }
    
    func addRoutine(_ routineName: String, _ startTime: String, _ endTime: String, _ repeatOn: [Int], _ project: String){
        
        let newRoutine = Routine(id: UUID().hashValue, routineName: routineName, startTime: startTime, endTime: endTime, repeatOn: repeatOn, project: project)
        
        userRoutines += [newRoutine]
    }
    
    func saveRoutine(){
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self.userRoutines) {
            UserDefaults.standard.set(data, forKey: "UserRoutines")
        }
    }
    
    func loadRoutine( _ key: String){
        if let savedGoals = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let loadedGoals = try? decoder.decode([Goal].self, from: savedGoals) {
                self.userGoals += loadedGoals
            }
        }
    }
    
    func getDaysRoutines(dayNum: Int) -> [Routine]{
        var routinesToReturn: [Routine] = []
        
        for routine in self.userRoutines{
            if routine.repeatOn.contains(dayNum){
                routinesToReturn += [routine]
            }
        }
        
        return routinesToReturn
    }
    
    func getNewGoalsFromRoutines(routines: [Routine], date: String) -> [Goal]{
        var goalsToReturn: [Goal] = []
        
        for routine in routines {
            goalsToReturn += [Goal(id: UUID().hashValue, goalName: routine.routineName, startTime: routine.startTime, endTime: routine.endTime, date: date, project: routine.project, done: false)]
        }
        
        return goalsToReturn
    }
    
    func addGoalAvoidingRepeat(goalToBeAdded: Goal){
        
        for usergoal in userGoals {
            
            if(usergoal.date == goalToBeAdded.date && usergoal.goalName == goalToBeAdded.goalName && usergoal.startTime == goalToBeAdded.startTime) {
                
                return
                
            }
            
        }
        
        userGoals += [goalToBeAdded]
        
    }
    
    //TODO: CHange everything to be a date object
    func checkRoutineAddGoalsAsNeeded(date: String, dayNum: Int){
        
        let dayRoutines = getDaysRoutines(dayNum: dayNum)
        
        for routine in dayRoutines{
            
            let tempGoal = Goal(id: UUID().hashValue, goalName: routine.routineName, startTime: routine.startTime, endTime: routine.endTime, date: date, project: routine.project, done: false)
            
            self.addGoalAvoidingRepeat(goalToBeAdded: tempGoal)
            
        }
        
    }
    
}

