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
    @Published var userProjects = loadSavedProjects()
    
    func addGoal(_ goalName: String, _ startTime: Date, _ endTime: Date, _ date: String, _ project: String){
        
        let newGoal = Goal(id: UUID().hashValue, goalName: goalName, startTime: startTime, endTime: endTime, date: date, project: project, done: false)
        
        userGoals += [newGoal]
    }
    
    func saveGoal(){
        self.userGoals = self.userGoals.sorted(by: {$0.startTime < $1.startTime })
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self.userGoals) {
            UserDefaults.standard.set(data, forKey: "Usergoals")
        }
    }
    
    func loadGoal( _ key: String){
        if let savedGoals = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let loadedGoals = try? decoder.decode([Goal].self, from: savedGoals) {
                self.userGoals += loadedGoals
            }
        }
    }
    
    func removeGoal(goal: Goal){
        self.userGoals.removeAll { $0 == goal}
        self.saveGoal()
    }
    func removeRoutine(routine: Routine){
        self.userRoutines.removeAll { $0 == routine}
        self.saveRoutine()
    }
    func removeProject(project: Project){
        self.userProjects.removeAll { $0 == project}
        self.saveProjects()
    }
    
    func addRoutine(_ routineName: String, _ startTime: Date, _ endTime: Date, _ repeatOn: [Bool], _ project: String){
        
        let newRoutine = Routine(id: UUID().hashValue, routineName: routineName, startTime: startTime, endTime: endTime, repeatOn: repeatOn, project: project)
        
        userRoutines += [newRoutine]
    }
    
    func saveRoutine(){
        self.userRoutines = self.userRoutines.sorted(by: {$0.startTime < $1.startTime })
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
            if routine.repeatOn[dayNum] && routine.running {
                routinesToReturn += [routine]
            }
        }
        return routinesToReturn
    }
    
    //I think this can be deleted
//    func getNewGoalsFromRoutines(routines: [Routine], date: String) -> [Goal]{
//        var goalsToReturn: [Goal] = []
//
//        for routine in routines {
//            goalsToReturn += [Goal(id: UUID().hashValue, goalName: routine.routineName, startTime: routine.startTime, endTime: routine.endTime, date: date, project: routine.project, done: false)]
//        }
//        return goalsToReturn
//    }
    func addGoalAvoidingRepeat(goalToBeAdded: Goal){
        
        for usergoal in userGoals {
            if(usergoal.date == goalToBeAdded.date && usergoal.goalName == goalToBeAdded.goalName && usergoal.startTime == goalToBeAdded.startTime) {
                return
            }
        }
        userGoals += [goalToBeAdded]
    }
    
    func combineTimeAndDay(time: Date, day: Date) -> Date {
        
        var components = DateComponents()
        components.hour = Calendar.current.component(.hour, from: time)
        components.minute = Calendar.current.component(.minute, from: time)
        components.day = Calendar.current.component(.day, from: day)
        components.month = Calendar.current.component(.month, from: day)
        components.year = Calendar.current.component(.year, from: day)
        let date = Calendar.current.date(from: components) ?? Date()
        
        return date
    }
    
    func checkRoutineAddGoalsAsNeeded(dayNum: Int){
        let dayRoutines = getDaysRoutines(dayNum: dayNum)
        
        for routine in dayRoutines{
            
            let startDate = combineTimeAndDay(time: routine.startTime, day: Date())
            let endDate = combineTimeAndDay(time: routine.endTime, day: Date())
            
            
            let tempGoal = Goal(id: UUID().hashValue, goalName: routine.routineName, startTime: startDate, endTime: endDate, project: routine.project, done: false)
            
            self.addGoalAvoidingRepeat(goalToBeAdded: tempGoal)
        }
        self.saveGoal()
    }
    
    func addProject(projectName: String){
         
        let newProject = Project(id: UUID().hashValue, projectName: projectName)
        self.userProjects += [newProject]
        self.saveProjects()
    }
    
    func loadProjects(){
        
        if let savedProjects = UserDefaults.standard.object(forKey: "Projects") as? Data {
            let decoder = JSONDecoder()
            if let loadedProjects = try? decoder.decode([Project].self, from: savedProjects) {
                self.userProjects += loadedProjects
            }
        }
    }
    
    func saveProjects(){
        
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self.userProjects) {
            UserDefaults.standard.set(data, forKey: "UserProjects")
        }
        
    }
}


