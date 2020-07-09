//
//  RoutineView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/8/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct RoutineView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var orientationInfo : OrientationInfo
    @State var addingRoutine: Bool
    @State var routineBeingEditedID: Int = 0
    @State var editingRoutine: Bool = false
    
    var body: some View {
        ZStack{
            if(orientationInfo.orientation == .portrait){
                VStack(alignment: .leading, spacing: 0){
                    Text("Routines")
                        .foregroundColor(Color.black)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding()
                        .padding(.leading, 10)
                        .multilineTextAlignment(.leading)
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(spacing: 10){
                            
                            ForEach(userData.userRoutines) {routine in
                                RoutineBox(routine: routine)
                                    .onLongPressGesture {
                                        self.routineBeingEditedID = routine.id
                                        self.editingRoutine.toggle()
                                }
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
                                            .frame(width: 20, height: 20)
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
            
            if(addingRoutine){
                GeometryReader{_ in
                    BlurView(style: .light)
                        .onTapGesture {
                            self.addingRoutine.toggle()
                    }
                    
                    AddRoutineNoBack(userData: self._userData, addingItem: self.$addingRoutine)
                        .padding(.top, 40)
                        .padding(.leading, -10)
                    
                }.background(
                    Color.black.opacity(0.65)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.addingRoutine.toggle()
                    }
                )
                    .edgesIgnoringSafeArea(.all)
            }
            else{
                Button(action: {self.addingRoutine.toggle()}) {
                    AddButton()
                }
                .scaleEffect(0.2)
                .offset(x: 130, y: 270)
                //TODO: This needs to be adjusted to work with all screen sizes
            }
            
            if(editingRoutine){
                GeometryReader{_ in
                    BlurView(style: .light)
                        .onTapGesture {
                            self.editingRoutine.toggle()
                    }
                    EditRoutine(editingRoutine: self.$editingRoutine, routineID: self.routineBeingEditedID)
                        .padding(.top, 40)
                        .padding(.leading, -10)
                }.background(
                    Color.black.opacity(0.65)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.editingRoutine.toggle()
                    }
                )
                    .edgesIgnoringSafeArea(.all)
            }
        }
        
    }
}
//
//struct RoutineView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoutineView()
//    }
//}
