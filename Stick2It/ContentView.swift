//
//  ContentView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/4/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let goals = ["Goal One", "Goal Two", "Goal Three"]
    //let testGoal2 = Goal(goalName: "Name2", done: true)
    
    var testGoalList = [Goal(goalName: "Goal 1", done: true), Goal(goalName: "Goal 2", done: false), Goal(done: false), Goal(goalName: "Goal 4", done: true)]
    
    var body: some View {

        VStack{
            //Text("Top")
            
            //GoalBox(goal: testGoal2)
            
            ForEach(testGoalList, id: \.id) {
                GoalBox(goal: $0)
                
                //.background(Color.white.shadow(radius: 10))
                //.overlay(Rectangle().stroke(Color.white, lineWidth: 4))
                .padding(5)
                
                
                
            }
            
            //Text("Bottom")
        }
    .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
