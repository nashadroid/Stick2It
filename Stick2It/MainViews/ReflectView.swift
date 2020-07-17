//
//  Reflect.swift
//  Stick2It
//
//  Created by Nashad Rahman on 7/10/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct ReflectView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var orientationInfo : OrientationInfo
    @State var routineBeingEditedID: Int = 0
    @State var editingRoutine: Bool = false
    
    var body: some View {
        ZStack{
            if(orientationInfo.orientation == .portrait){
                
                VStack(alignment: .leading, spacing: 0){
                    Text("Yesterday's Goals")
                        .foregroundColor(Color.black)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding()
                        .padding(.leading, 10)
                        .multilineTextAlignment(.leading)
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(spacing: 10){
                            
                            ForEach(self.userData.userGoals.filter({Calendar.current.isDate($0.startTime, inSameDayAs: getYesterday())})) {goal in
                                
                                ReflectionGoalBox(goal: goal)
                                    .onLongPressGesture {
                                        self.userData.userGoals[self.userData.getIndex(goal: goal)].done.toggle()
                                        self.userData.saveGoal()
                                        softGenerator.impactOccurred()
                                    }
                                
                            }
                        }
                        .padding()
                    }
                }
            }
            else{
                ScrollView{
                    VStack(){
                    Text("Past Week")
                        .foregroundColor(Color.black)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 20)
                    HStack{
                        
                            
                            
                            VStack(alignment: .trailing){
                                ForEach(userData.userRoutines, id: \.self){ routine in
                                    HStack{
                                        Text(routine.routineName)
                                            .fontWeight(.bold)
                                        ForEach(getPastWeek(), id: \.self){ day in
                                            Rectangle()
                                                .fill(self.userData.goalDoneOnDay(goalName: routine.routineName, Date: day) == 0 ? Color.red : Color.green)
                                                .opacity(self.userData.goalDoneOnDay(goalName: routine.routineName, Date: day) == -1 ? 0.1 : 1)
                                                .frame(width: 30, height: 30)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.leading)
                        .padding(.bottom, 40)
                        Spacer()
                    }
                }
            }
        }
    }
}

//struct ReflectView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReflectView(, addingRoutine: <#Bool#>)
//    }
//}
