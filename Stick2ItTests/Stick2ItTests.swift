//
//  Stick2ItTests.swift
//  Stick2ItTests
//
//  Created by Nashad Rahman on 5/4/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import XCTest
@testable import Stick2It

class Stick2ItTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGoalCanBuild() {
        
        let testGoal = Goal(id: UUID().hashValue, goalName: "Test Goal", startTime: Date(), endTime: Date(), done: false)
        XCTAssertEqual(testGoal.goalName ,"Test Goal")
    }
    
    func testRoutineCanBuild() {
        
        let testRoutine = Routine(id: UUID().hashValue, routineName: "Test Routine", startTime: Date(), endTime: Date())
        XCTAssertEqual(testRoutine.routineName ,"Test Routine")
    }
    
    func testUserDataCanAddGoal() {
        
        let userData = UserData()
        userData.addGoal("TestGoal", Date(), Date(), "none")
        XCTAssertEqual(userData.userGoals[userData.userGoals.endIndex - 1].goalName, "TestGoal")
    }
    
    func testUserDataCanAddRoutine() {
        
        let userData = UserData()
        let repeatOnDays = [true,true,true,true,true,true,true]
        userData.addRoutine("TestRoutine", Date(), Date(), repeatOnDays,"None")
        XCTAssertEqual(userData.userRoutines[userData.userRoutines.endIndex - 1].routineName, "TestRoutine")
    }
    
    func testPerformanceOfRefresh() {
        
        let userData = UserData()
        self.measure {
            userData.refresh()
        }
    }
    
    func testPerformanceToAddGoal() {
        
        let userData = UserData()
        self.measure {
            userData.addGoal("TestGoal", Date(), Date(), "none")
        }
    }
    
    func testPerformanceAddFromRoutine() {
        
        let userData = UserData()
        self.measure {
            for i in 0...6 {
                userData.checkRoutineAddGoalsAsNeeded(dayNum: i)
            }
        }
    }
    
    func testPerformanceSave() {
        
        let userData = UserData()
        self.measure {
            userData.saveGoal()
            userData.saveNotes()
            userData.saveRoutine()
        }
    }
    
    func testGoalIndex() {
        
        let userData = UserData()
        userData.addGoal("TestGoal", Date(), Date(), "none")
        XCTAssertEqual(userData.getIndex(goal: userData.userGoals[userData.userGoals.endIndex - 1]), userData.userGoals.endIndex - 1)
    }
    
    func testRoutineIndex() {
        
        let userData = UserData()
        let repeatOnDays = [true,true,true,true,true,true,true]
        userData.addRoutine("TestRoutine", Date(), Date(), repeatOnDays,"None")
        XCTAssertEqual(userData.getIndex(routine: userData.userRoutines[userData.userRoutines.endIndex - 1]), userData.userRoutines.endIndex - 1)
    }
}

class Stick2ItLongTermUseTest: XCTestCase {
    
    func testPerformanceToAdd10k() {
        // If a person has on average say 25 goals per day, and uses the app for 10 years,
        // then after 10 years they will have aquired 91250 goals.
        // 10,000 goals seems like a reasonable test of memory used.
        
        let userData = UserData()
        
        self.measure {
            userData.addGoal("TestGoal", Date(), Date(), "none")
            for i in 0...10000 {
                userData.addGoal("TestGoal" + String(i), Date(), Date(), "none")
                print(i)
            }
        }
        
        
    }
    func testPerformanceToAddGoalAfter10k() {
        // If a person has on average say 25 goals per day, and uses the app for 10 years,
        // then after 10 years they will have aquired 91250 goals.
        // Importantly, here we want to test that adding a new goal still takes
        // a negligible amount of time.
        
        let userData = UserData()
        for i in 0...10000 {
            userData.addGoal("TestGoal" + String(i), Date(), Date(), "none")
        }
        
        self.measure {
            userData.addGoal("TestGoal", Date(), Date(), "none")
        }
    }
    
}
