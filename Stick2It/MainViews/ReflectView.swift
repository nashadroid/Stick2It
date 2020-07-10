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
                                
                                GoalBox(goal: goal)
                                
                            }
                        }
                        .padding()
                        .frame(minWidth: UIScreen.main.bounds.size.width)
                    }
                }
            }
            else{
                ScrollView{
                    HStack{
                        VStack(alignment: .trailing){
                            ForEach(userData.userRoutines, id: \.self){ routine in
                                HStack{
                                    Text(routine.routineName)
                                        .fontWeight(.bold)
                                    ForEach(getPastWeek(), id: \.self){ day in
                                        Rectangle()
                                            .fill(self.userData.goalDoneOnDay(goalName: routine.routineName, Date: day) == 1 ? Color.green : Color.red)
                                            .opacity(self.userData.goalDoneOnDay(goalName: routine.routineName, Date: day) == -1 ? 0.1 : 1)
                                            .frame(width: 30, height: 30)
                                    }
                                }
                            }
                        }
                        .padding(.leading)
                        .padding(.top,80)
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
