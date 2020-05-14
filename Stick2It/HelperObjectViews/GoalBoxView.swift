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
    @State var goal: Goal //TODO: Change this to be an index or ID only
    
    var goalIndex: Int {
        userData.userGoals.firstIndex(where: { $0.id == goal.id }) ?? 0
    }
    
    var body: some View {

            HStack{
                
                VStack(alignment: .leading){
                    Text(goal.goalName)
                        .font(.headline)
                        .fontWeight(.heavy)
                        .padding(.leading, 10)
                        .foregroundColor(self.userData.userGoals[self.goalIndex].done ? Color.white : Color.black)
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
                    .background(self.userData.userGoals[self.goalIndex].done ? Color.green : Color.red)
            }
            .background(self.userData.userGoals[self.goalIndex].done ? Color.green.shadow(radius: 7) : Color.white.shadow(radius: 7))
            .onTapGesture {
                self.goal.done.toggle()
                self.userData.userGoals[self.goalIndex].done.toggle()
                self.userData.saveGoal()
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
            }
            .onLongPressGesture {
                self.userData.removeGoal(goal: self.goal)
            }
        
    }
}

var testGoal = Goal(id: 2020, goalName: "Name1", startTime: Date(), endTime: Date(), date: "000000", project: "none", done: true)

struct GoalBox_Previews: PreviewProvider {
    
    static var previews: some View {
        
        GoalBox(goal: testGoal)
            .environmentObject(UserData())
        
    }
}
