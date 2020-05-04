//
//  GoalBoxView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/4/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct GoalBox: View {
    @State var goal: Goal
    //@State private var didTap:Bool = false
    
    var body: some View {
        
        Button(action: {
            //TODO: Make sure this gets saved somewhere
             //self.didTap = !self.didTap
            let temp: Bool = !self.goal.done
            self.goal.done = temp
        }) {
        
        HStack{
            
            VStack(alignment: .leading){
                Text(goal.goalName)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .padding(.leading, 10)
                    .foregroundColor(self.goal.done ? Color.white : Color.black)
                Text("\(goal.startTime) - \(goal.endTime)")
                    //.italic()
                    .font(.footnote)
                    .padding(.leading, 10)
                    .foregroundColor(self.goal.done ? Color.white : Color.gray)
                
                    
            }
            Spacer()
            
//            Button(action: {
//                //TODO: Make sure this gets saved somewhere
//                 self.didTap = !self.didTap
//            }) {
                Text(self.goal.done ? "Done" : "To-Do")
                .foregroundColor(Color.white)
                .fontWeight(.heavy)
                .padding()
                .background(self.goal.done ? Color.green : Color.red)
            }
            
        }
        .background(self.goal.done ? Color.green.shadow(radius: 7) : Color.white.shadow(radius: 7))
        
        
        //.shadow(radius: 10)
        
        
    
    
    }
}

    var testGoal = Goal(goalName: "Name1", startTime: "00:00", endTime: "00:00", done: true)

struct GoalBox_Previews: PreviewProvider {
    
    static var previews: some View {
        
        GoalBox(goal: testGoal)
        //.previewLayout(.fixed(width: 300, height: 70))
        
    }
}
