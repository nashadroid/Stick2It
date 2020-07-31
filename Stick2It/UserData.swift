//
//  UserData.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/5/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI
import Combine
import EventKit

//These functions are needed at startup and thus are placed at top level
func loadSavedGoals() -> [Goal]{
    if let savedGoals = UserDefaults.standard.object(forKey: "Usergoals") as? Data {
        let decoder = JSONDecoder()
        if let loadedGoals = try? decoder.decode([Goal].self, from: savedGoals) {
            return loadedGoals
        }
    }
    return [Goal(id: UUID().hashValue , goalName: "Add a Goal to get started!", startTime: oldestDate(), endTime: oldestDate(), done: false)]
}

func loadSavedRoutines() -> [Routine]{
    if let savedRoutines = UserDefaults.standard.object(forKey: "UserRoutines") as? Data {
        let decoder = JSONDecoder()
        if let loadedRoutine = try? decoder.decode([Routine].self, from: savedRoutines) {
            return loadedRoutine
        }
    }
    
    return[]
//return [Routine(id: UUID().hashValue, routineName: "Add a routine to get started!", startTime: oldestDate(), endTime: oldestDate())]
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
func loadSavedCalendars() -> [NCalendar]{
    
    if let savedProjects = UserDefaults.standard.object(forKey: "UserCalendars") as? Data {
        let decoder = JSONDecoder()
        if let loadedCals = try? decoder.decode([NCalendar].self, from: savedProjects) {
            return loadedCals
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

enum loadError: Error {
    case outOfIndex
}

// This object is used to store all user info throughout the app
final class UserData: ObservableObject  {
    @Published var userGoals: [Goal]
    @Published var userRoutines: [Routine]
    @Published var userProjects: [Project]
    @Published var userCalendars: [NCalendar]
    @Published var userNotes: Dictionary<String, String>
    
    init() {
        userGoals = loadSavedGoals()
        userRoutines = loadSavedRoutines()
        userProjects = loadSavedProjects()
        userCalendars = loadSavedCalendars()
        userNotes = loadSavedNotes()
        changeOldRemainGoalsToday()
        addGoalsFromCal() //TODO Move this
        checkCalendarsAddAccordingly()
        for day in getNextWeek(){
            checkRoutineAddGoalsAsNeeded(day: day)
        }
    }
    
    //Add objects
    func addGoal(goalName: String, startTime: Date, endTime: Date, scheduled: Bool, remain: Bool, project: String){
        let newGoal = Goal(id: UUID().hashValue, goalName: goalName, startTime: startTime, endTime: endTime, scheduled: scheduled, remain: remain, project: project, done: false)
        userGoals += [newGoal]
        newNotificationFromGoal(goal: newGoal)
    }
    func addRoutine(routineName: String, startTime: Date, endTime: Date, scheduled: Bool, repeatOn: [Bool], project: String){
        let newRoutine = Routine(id: UUID().hashValue, routineName: routineName, startTime: startTime, endTime: endTime, scheduled: scheduled, repeatOn: repeatOn, project: project)
        userRoutines += [newRoutine]
        for day in getNextWeek(){
            checkRoutineAddGoalsAsNeeded(day: day)
        }
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
    
    // Get note from a day. A string:string dictionary seems the most reliable for this as date components can be optionals
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
    func saveCalendars(){
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self.userCalendars) {
            UserDefaults.standard.set(data, forKey: "UserCalendars")
        } else {
            print("could not save calendar")
        }
    }
    func saveNotes(){
        UserDefaults.standard.set(self.userNotes, forKey: "UserNotes")
    }
    
    //Remove Objects
    func removeGoal(goal: Goal){
//        self.userGoals[self.userGoals.firstIndex(where: {$0 == goal}) ?? 0].enabled = false
        self.userGoals[self.userGoals.firstIndex(where: {$0 == goal}) ?? 0].deleted = true
        self.saveGoal()
        self.refreshNotifications()
    }
    func disableGoal(goal: Goal){
        self.userGoals[self.userGoals.firstIndex(where: {$0 == goal}) ?? 0].enabled = false
        self.saveGoal()
        self.refreshNotifications()
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
    func checkRoutineAddGoalsAsNeeded(day: Date){
        let dayNum =  Calendar.current.component(.weekday, from: day) - 1
        let dayRoutines = self.userRoutines.filter({$0.repeatOn[dayNum] && $0.running})
        
        for routine in dayRoutines{
            
            let startDate = combineTimeAndDay(time: routine.startTime, day: day)
            let endDate = combineTimeAndDay(time: routine.endTime, day: day)
            
            
            let tempGoal = Goal(
                id: UUID().hashValue,
                goalName: routine.routineName,
                startTime: startDate,
                endTime: endDate,
                scheduled: routine.scheduled,
                project: routine.project,
                done: false
            )
            
            self.addGoalAvoidingRepeat(goalToBeAdded: tempGoal)
        }
        self.saveGoal()
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
        
        if self.userGoals.firstIndex(where: {$0.goalName == goalToBeAdded.goalName && $0.startTime == goalToBeAdded.startTime}) != nil{
            return
        }
        newNotificationFromGoal(goal: goalToBeAdded)
        userGoals += [goalToBeAdded]
    }
    
    //Change unfinished remain goals to be today
    func changeOldRemainGoalsToday() {
        for goal in self.userGoals.filter({$0.remain && !$0.done && $0.enabled}) {
            
            if let goalIndex = self.userGoals.firstIndex(of: goal){
                self.userGoals[goalIndex].startTime = Date()
                self.userGoals[goalIndex].endTime = Date()
            }
        }
    }
    
    func goalDoneOnDay(goalName: String, Date: Date) -> Int{
        
        var done: [Bool] = []
        done = self.userGoals.filter({Calendar.current.isDate($0.startTime, inSameDayAs: Date) && $0.goalName == goalName}).map({return $0.done})
        
        if (done != []){
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
    
    func newNotificationFromGoal(goal: Goal) {
        let content = UNMutableNotificationContent()
        content.title = goal.goalName
        content.body = getTimeStringFromDate(goal.startTime)
        content.sound = UNNotificationSound.default
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: goal.startTime)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
    func getListOfCal() -> [String] {
        let store = EKEventStore()
        store.requestAccess(to: .event, completion: {_,_ in })
        let calendars = store.calendars(for: .event)
        
        let calendarTitles = calendars.map{(cal) -> String in
            return cal.title
        }
        return calendarTitles
    }
    func checkCalendarsAddAccordingly() {
        let store = EKEventStore()
        store.requestAccess(to: .event, completion: {_,_ in })
        let calendars = store.calendars(for: .event)
        
        let calendarTitles = calendars.map{(cal) -> String in
            return cal.title
        }
        
        for calTitle in calendarTitles {
            addCalAvoidRepeat(calTitle: calTitle)
        }
    }
    func addCalAvoidRepeat(calTitle: String) {
        if self.userCalendars.firstIndex(where: {$0.calendarName == calTitle}) != nil{
            return
        }
        self.userCalendars += [NCalendar(id: UUID().hashValue, calendarName: calTitle)]
        self.saveCalendars()
    }
    func addGoalsFromCal() {
        
        if !(UserDefaults.standard.object(forKey: "allowNotifications") as? Bool ?? false) {
            return
        }
        
        let store = EKEventStore()
        store.requestAccess(to: .event, completion: {_,_ in }) //TODO
        let calendars = store.calendars(for: .event)
        
        let ONCalendarTitles = self.userCalendars.filter({$0.enabled}).map{(cal) -> String in
            return cal.calendarName
        }
        let ONCalendars = calendars.filter({ONCalendarTitles.contains($0.title)})
        
        let predicate = store.predicateForEvents(withStart: getYesterday(), end: getTomorrow(), calendars: ONCalendars)
        
        let calEvents = store.events(matching: predicate)
        let ONCalEvents = calEvents.filter({ONCalendars.contains($0.calendar)})
        
        for event in ONCalEvents {
            
            let nCal = userCalendars.first(where: {$0.calendarName == event.calendar.title})
            
            let goalToBeAdded = Goal(id: UUID().hashValue, goalName: event.title, startTime: event.startDate, endTime: event.endDate, scheduled: true, remain: false, project: "none", catagory: "none", done: false, calendar: nCal)
            
            addGoalAvoidingRepeat(goalToBeAdded: goalToBeAdded)
        }
    }
    func refreshNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        if (UserDefaults.standard.object(forKey: "allowNotifications") as? Bool ?? false) {
            for day in getNextWeek() {
                for goal in self.userGoals.filter({Calendar.current.isDate($0.startTime, inSameDayAs: day) && $0.enabled}) {
                    self.newNotificationFromGoal(goal: goal)
                }
            }
        }
    }
    func refeshEnabledFromCalendars() {
//        for cal in self.userCalendars {
//            for goal in userGoals.filter({$0.calendar == cal}) {
//                if self.userGoals.firstIndex(of: goal) != nil {
//                    self.userGoals[self.userGoals.firstIndex(of: goal) ?? 0].enabled = cal.enabled
//                }
//            }
//        }
        let ONCalendarTitles = self.userCalendars.filter({$0.enabled}).map{(cal) -> String in
            return cal.calendarName
        }
        
        for goal in self.userGoals {
            
            if goal.calendar != nil {
                
                if ((UserDefaults.standard.object(forKey: "connectCalendar") as? Bool ?? false) && ONCalendarTitles.contains(goal.calendar?.calendarName ?? "")){
                    self.userGoals[self.userGoals.firstIndex(of: goal) ?? 0].enabled = true
                } else {
                    self.userGoals[self.userGoals.firstIndex(of: goal) ?? 0].enabled = false
                }
            }
        }
        self.saveGoal()
    }
}


