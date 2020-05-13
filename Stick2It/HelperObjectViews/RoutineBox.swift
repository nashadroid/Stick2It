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
                .foregroundColor(Color.white)
            
            
            Text("\(getTimeStringFromDate(self.userData.userRoutines[self.routineIndex].startTime)) - \(getTimeStringFromDate(self.userData.userRoutines[self.routineIndex].endTime))")
                .foregroundColor(Color.white)
            
            
            VStack(alignment: .leading, spacing: 0){
                HStack{
                    
                    Text("Project:")
                        .font(.body)
                        .fontWeight(.bold)
                        .padding(4)
                        .foregroundColor(Color.white)
                    
                    Text(self.userData.userRoutines[self.routineIndex].project)
                        .font(.body)
                        .padding(4)
                        .foregroundColor(Color.white)
                    Spacer()
                }
                Text("Repeated On:")
                    .fontWeight(.bold)
                    .padding(4)
                    .foregroundColor(Color.white)
                
                ForEach(0..<self.userData.userRoutines[self.routineIndex].repeatOn.count) {index in
                    
                    if(self.userData.userRoutines[self.routineIndex].repeatOn[index]){
                        Text(Calendar.current.weekdaySymbols[index])
                            .italic()
                            .padding(4)
                            .foregroundColor(Color.white)
                    }
                }
            }
        }
        .background(Color.green.shadow(radius: 7))
        .onTapGesture {
            
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
