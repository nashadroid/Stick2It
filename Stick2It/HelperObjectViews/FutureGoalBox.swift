//
//  FutureGoalBox.swift
//  Stick2It
//
//  Created by Nashad Rahman on 7/22/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct FutureGoalBox: View {
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
                    .fill(Color.green)
                    .opacity(self.userData.userGoals[self.goalIndex].done ? 1 : 0.45)
                    .shadow(radius: 7)
            )
        .onTapGesture {
            ()
        }
    }
}
