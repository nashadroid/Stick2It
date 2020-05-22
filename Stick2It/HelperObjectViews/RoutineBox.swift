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
            
            VStack(alignment: .leading, spacing: 0){
                Text(self.userData.userRoutines[self.routineIndex].routineName)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .padding(.leading, 10)
                    .foregroundColor(self.userData.userRoutines[self.routineIndex].running ? Color.white : Color.black)
                
                HStack{
                    Text("\(getTimeStringFromDate(self.userData.userRoutines[self.routineIndex].startTime)) - \(getTimeStringFromDate(self.userData.userRoutines[self.routineIndex].endTime))")
                    .foregroundColor(self.userData.userRoutines[self.routineIndex].running ? Color.white : Color.black)
                    .padding(.leading, 10)
                    .font(.footnote)
                    
                    Spacer()
                    
                    Text("Project:")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(self.userData.userRoutines[self.routineIndex].running ? Color.white : Color.black)
                    
                    Text(self.userData.userRoutines[self.routineIndex].project)
                        .font(.footnote)
                        .foregroundColor(self.userData.userRoutines[self.routineIndex].running ? Color.white : Color.black)
                        .padding(.trailing, 10)
                }
                Text(getShortStringFromRepeatDays(repeatedOn: self.userData.userRoutines[self.routineIndex].repeatOn))
                    .foregroundColor(self.userData.userRoutines[self.routineIndex].running ? Color.white : Color.black)
                    .padding(.leading, 10)
                    .font(.footnote)
                
            }
        }
        .background(self.userData.userRoutines[self.routineIndex].running ? Color.green.shadow(radius: 7) : Color.gray.shadow(radius: 7))
        .onTapGesture {
            self.userData.userRoutines[self.routineIndex].running.toggle()
        }
    }
}

//struct RoutineBox_Previews: PreviewProvider {
//    static var previews: some View {
//        RoutineBox()
//    }
//}
