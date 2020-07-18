//
//  GoalBoxView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/4/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct GoalBox: View {
    @EnvironmentObject var userData: UserData
    @State var goal: Goal
    
    var goalIndex: Int {
        userData.getIndex(goal: goal)
    }
    
    var body: some View {
        
        HStack{
            
            VStack(alignment: .leading){
                Text(goal.goalName)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .padding(.leading, 10)
                    .foregroundColor(self.userData.userGoals[self.goalIndex].done ? Color.white : Color.black)
                    .lineLimit(1)
                Text("\(getTimeStringFromDate(goal.startTime)) - \(getTimeStringFromDate(goal.endTime))")
                    .font(.footnote)
                    .padding(.leading, 10)
                    .foregroundColor(self.userData.userGoals[self.goalIndex].done ? Color.white : Color.gray)
                
                
            }
            Spacer()
            
            Text(self.userData.userGoals[self.goalIndex].done ? "Done" : "To-Do")
                .foregroundColor(Color.white)
                .fontWeight(.heavy)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 5)
                    .fill(self.userData.userGoals[self.goalIndex].done ? Color.green : Color.red)
                   
                )
        }
        .background(
            RoundedRectangle(cornerRadius: 5)
            .fill(self.userData.userGoals[self.goalIndex].done ? Color.green : Color.white)
            .shadow(radius: 7)
           
        )
        .onTapGesture {
            self.goal.done.toggle()
            self.userData.userGoals[self.goalIndex].done.toggle()
            self.userData.saveGoal()
            generator.impactOccurred()
        }
        
    }
}

var testGoal = Goal(id: 2020, goalName: "Name1", startTime: Date(), endTime: Date(), project: "none", done: true)

struct GoalBox_Previews: PreviewProvider {
    
    static var previews: some View {
        
        GoalBox(goal: testGoal)
            .environmentObject(UserData())
        
    }
}
