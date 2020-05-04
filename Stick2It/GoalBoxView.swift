//
//  GoalBoxView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/4/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct GoalBox: View {
    var goal: Goal
    @State private var didTap:Bool = false
    
    var body: some View {
        
        HStack{
            
            Text(goal.goalName)
                .font(.headline)
                .fontWeight(.heavy)
            Spacer()
            
            Button(action: {
                //goal.updateDone()
                print("Button Tapped")
                 self.didTap = !self.didTap
            }) {
            Text(goal.done ? "Done" : "To-Do")
                .foregroundColor(didTap ? Color.green : Color.red)
            }
        }
        .padding()
        
    
    
    }
}

var testGoal = Goal(goalName: "Name1", done: true)

struct GoalBox_Previews: PreviewProvider {
    
    static var previews: some View {
        
        GoalBox(goal: testGoal)
        .previewLayout(.fixed(width: 300, height: 70))
        
    }
}
