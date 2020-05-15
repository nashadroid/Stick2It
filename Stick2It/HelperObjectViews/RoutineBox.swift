//
//  RoutineBox.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/8/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct RoutineBox: View {
    @EnvironmentObject var userData: UserData
    @State var routine: Routine //TODO: Change this to be an index or ID only
    
    var routineIndex: Int {
        userData.userRoutines.firstIndex(where: { $0.id == routine.id }) ?? 0
    }
    
    var body: some View{
        
        VStack() {
            
            Text(self.userData.userRoutines[self.routineIndex].routineName)
                .font(.title)
                .fontWeight(.bold)
                .padding(4)
                .foregroundColor(self.userData.userRoutines[self.routineIndex].running ? Color.white : Color.black)
            
            Text("\(getTimeStringFromDate(self.userData.userRoutines[self.routineIndex].startTime)) - \(getTimeStringFromDate(self.userData.userRoutines[self.routineIndex].endTime))")
                .foregroundColor(self.userData.userRoutines[self.routineIndex].running ? Color.white : Color.black)
            
            
            VStack(alignment: .leading, spacing: 0){
                HStack{
                    
                    Text("Project:")
                        .font(.body)
                        .fontWeight(.bold)
                        .padding(4)
                        .foregroundColor(self.userData.userRoutines[self.routineIndex].running ? Color.white : Color.black)
                    
                    Text(self.userData.userRoutines[self.routineIndex].project)
                        .font(.body)
                        .padding(4)
                        .foregroundColor(self.userData.userRoutines[self.routineIndex].running ? Color.white : Color.black)
                    Spacer()
                }
                Text("Repeated On: " + getShortStringFromRepeatDays(repeatedOn: self.userData.userRoutines[self.routineIndex].repeatOn))
                    .fontWeight(.bold)
                    .padding(4)
                    .foregroundColor(self.userData.userRoutines[self.routineIndex].running ? Color.white : Color.black)
                
            }
        }
        .background(self.userData.userRoutines[self.routineIndex].running ? Color.green.shadow(radius: 7) : Color.gray.shadow(radius: 7))
        .onTapGesture {
            self.userData.userRoutines[self.routineIndex].running.toggle()
        }
        .onLongPressGesture {
            self.userData.removeRoutine(routine: self.routine)
        }
        
    }
}

//struct RoutineBox_Previews: PreviewProvider {
//    static var previews: some View {
//        RoutineBox()
//    }
//}
