//
//  ContentView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/4/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    var defaultGoalList = [
        Goal(goalName: "Wake up, out of bed",
             startTime: "9:00 am",
             endTime: "9:18 am",
             done: true),
        Goal(goalName: "Run",
             startTime: "9:25 am",
             endTime: "10:00 am",
             done: true),
        Goal(goalName: "Shower, Brush Teeth",
             startTime: "10:10 am",
             endTime: "10:30 am",
             done: false),
        Goal(goalName: "Breakfast",
             startTime: "10:30 am",
            endTime: "11:00 am",
            done: false),
        Goal(goalName: "Programming",
            startTime: "11:00 am",
            endTime: "1:00 pm",
            done: false),
        Goal(goalName: "Lunch",
            startTime: "1:00 pm",
            endTime: "2:00 pm",
            done: false),
        Goal(goalName: "Music",
            startTime: "1:00 pm",
            endTime: "2:00 pm",
            done: false),
    
    
    ]
    
    var body: some View {
        Color.white
            .overlay(
                VStack{
                    
                    ForEach(defaultGoalList, id: \.id) {
                        GoalBox(goal: $0)
                        
                        .padding(5)
                        
                    }
                    
                    
                }
                .padding()
        )
        .edgesIgnoringSafeArea(.all)
            
    
    
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

