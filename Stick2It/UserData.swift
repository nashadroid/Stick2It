//
//  UserData.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/5/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI
import Combine

func loadSavedGoals() -> [Goal]{
    if let savedGoals = UserDefaults.standard.object(forKey: "Usergoals") as? Data {
        let decoder = JSONDecoder()
        if let loadedGoals = try? decoder.decode([Goal].self, from: savedGoals) {
            return loadedGoals
        }
    }
    return []
}

func loadSavedRoutines() -> [Routine]{
    if let savedRoutines = UserDefaults.standard.object(forKey: "UserRoutines") as? Data {
        let decoder = JSONDecoder()
        if let loadedRoutine = try? decoder.decode([Routine].self, from: savedRoutines) {
            return loadedRoutine
        }
    }
    return []
}

func loadSavedProjects() -> [Project]{
    
    if let savedProjects = UserDefaults.standard.object(forKey: "UserProjects") as? Data {
        let decoder = JSONDecoder()
        if let loadedProjects = try? decoder.decode([Project].self, from: savedProjects) {
            return loadedProjects
        }
    }
    return []
}

func loadSavedNotes() -> Dictionary<String, String>{
    
    if let savedNotes = UserDefaults.standard.object(forKey: "UserNotes") as? Dictionary<String, String> {
        return savedNotes
    }
    return ["Default":"Error"]
}

final class UserData: ObservableObject  {
    @Published var userGoals: [Goal]
    @Published var userRoutines: [Routine]
    @Published var userProjects: [Project]
    @Published var userNotes: Dictionary<String, String>
    
    init() {
        userGoals = loadSavedGoals()
        userRoutines = loadSavedRoutines()
        userProjects = loadSavedProjects()
        userNotes = loadSavedNotes()
        checkRoutineAddGoalsAsNeeded(dayNum: Calendar.current.component(.weekday, from: Date()) - 1)
        
    }
    
    //Add objects
    func addGoal(_ goalName: String, _ startTime: Date, _ endTime: Date, _ project: String){
        let newGoal = Goal(id: UUID().hashValue, goalName: goalName, startTime: startTime, endTime: endTime, project: project, done: false)
        userGoals += [newGoal]
    }
    func addRoutine(_ routineName: String, _ startTime: Date, _ endTime: Date, _ repeatOn: [Bool], _ project: String){
        let newRoutine = Routine(id: UUID().hashValue, routineName: routineName, startTime: startTime, endTime: endTime, repeatOn: repeatOn, project: project)
        userRoutines += [newRoutine]
    }
    func addProject(projectName: String){
        let newProject = Project(id: UUID().hashValue, projectName: projectName)
        self.userProjects += [newProject]
        self.saveProjects()
    }
    func addNote(note: String, day: String) {
        userNotes[day] = note
        saveNotes()
    }
    
    func getNote(day: String) -> String {
        if let note = userNotes[day] {
            return note
        }
        return ""
    }
    
    //Save Objects
    func saveGoal(){
        self.userGoals.sort(by: {getTimeIntFromDate($0.startTime) < getTimeIntFromDate($1.startTime)})
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self.userGoals) {
            UserDefaults.standard.set(data, forKey: "Usergoals")
        }
    }
    func saveRoutine(){
        self.userRoutines.sort(by: {getTimeIntFromDate($0.startTime) < getTimeIntFromDate($1.startTime)})
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self.userRoutines) {
            UserDefaults.standard.set(data, forKey: "UserRoutines")
        }
    }
    func saveProjects(){
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self.userProjects) {
            UserDefaults.standard.set(data, forKey: "UserProjects")
        }
    }
    func saveNotes(){
        UserDefaults.standard.set(self.userNotes, forKey: "UserNotes")
    }
    
    //Remove Objects
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
    
    //Refresh
    func refresh() {
        userGoals = loadSavedGoals()
        userRoutines = loadSavedRoutines()
        userProjects = loadSavedProjects()
    }
    
    //Get Index of Goal
    func getIndex(goal: Goal) -> Int{
        return self.userGoals.firstIndex(where: { $0.id == goal.id }) ?? 0
    }
    func getIndex(routine: Routine) -> Int{
        return self.userRoutines.firstIndex(where: { $0.id == routine.id }) ?? 0
    }
    
    
    //Add goals from routine methods
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
    func getDaysRoutines(dayNum: Int) -> [Routine]{
        var routinesToReturn: [Routine] = []
        
        for routine in self.userRoutines{
            if routine.repeatOn[dayNum] && routine.running {
                routinesToReturn += [routine]
            }
        }
        return routinesToReturn
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
    func addGoalAvoidingRepeat(goalToBeAdded: Goal){
        
        for usergoal in userGoals {
            if(usergoal.goalName == goalToBeAdded.goalName && usergoal.startTime == goalToBeAdded.startTime) {
                return
            }
        }
        userGoals += [goalToBeAdded]
    }
    
    func goalDoneOnDay(goalName: String, Date: Date) -> Int{
        
        var done: [Bool] = []
        done = self.userGoals.filter({Calendar.current.isDate($0.startTime, inSameDayAs: Date) && $0.goalName == goalName}).map({return $0.done})
        
        if (done.count == 1){
            if done[0] == true {
                return 1
            }
            else{
                return 0
            }
        }
        else{
            return -1
        }
        
    }
}


