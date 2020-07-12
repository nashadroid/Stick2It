//
//  ReflectionGoalBox.swift
//  Stick2It
//
//  Created by Nashad Rahman on 7/10/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct ReflectionGoalBox: View {
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
                        .foregroundColor(Color.white)
                        .lineLimit(1)
                    Text("\(getTimeStringFromDate(goal.startTime)) - \(getTimeStringFromDate(goal.endTime))")
                        .font(.footnote)
                        .padding(.leading, 10)
                        .foregroundColor(Color.white)
                    
                    
                }
                Spacer()
                
                Text(" ")
                    .foregroundColor(Color.white)
                    .fontWeight(.heavy)
                    .padding()
                    //.background(self.userData.userGoals[self.goalIndex].done ? Color.green : Color.red)
            }
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(self.userData.userGoals[self.goalIndex].done ? Color.green : Color.red)
                    .opacity(0.75)
                    .shadow(radius: 7)
            )
                    
            .onLongPressGesture {
                self.goal.done.toggle()
                self.userData.userGoals[self.goalIndex].done.toggle()
                self.userData.saveGoal()
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
            }
        
    }
}
