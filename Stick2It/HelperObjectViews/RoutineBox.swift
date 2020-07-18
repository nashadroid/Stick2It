//
//  RoutineBox.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/8/20.
//  Copyright © 2020 NashApps. All rights reserved.
//
//  Box used in routine view

import SwiftUI

struct RoutineBox: View {
    @EnvironmentObject var userData: UserData
    @State var routine: Routine
    
    var routineIndex: Int {
        userData.getIndex(routine: routine)
    }
    
    var body: some View{
        VStack(alignment: .leading, spacing: 0){
            Text(self.userData.userRoutines[self.routineIndex].routineName)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
            
            HStack{
                Text("\(getTimeStringFromDate(self.userData.userRoutines[self.routineIndex].startTime)) - \(getTimeStringFromDate(self.userData.userRoutines[self.routineIndex].endTime))")
                    .foregroundColor(Color.white)
                    .font(.footnote)
                
                Spacer()
                
                if(self.userData.userRoutines[self.routineIndex].project != "none"){
                    Text("Project:")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    
                    Text(self.userData.userRoutines[self.routineIndex].project)
                        .font(.footnote)
                        .foregroundColor(Color.white)
                }
            }
            Text(getShortStringFromRepeatDays(repeatedOn: self.userData.userRoutines[self.routineIndex].repeatOn))
                .foregroundColor(Color.white)
                .font(.footnote)
            
        }
        .padding()
        .background(
            
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.green)
                .opacity(self.userData.userRoutines[self.routineIndex].running ? 1 : 0.4)
                .shadow(radius: 7)
        )
        .onTapGesture {
            self.userData.userRoutines[self.routineIndex].running.toggle()
            softGenerator.impactOccurred()
        }
    }
}

//struct RoutineBox_Previews: PreviewProvider {
//    static var previews: some View {
//        RoutineBox()
//    }
//}
