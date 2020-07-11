//
//  TodayView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/8/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct TodayView: View {
    @EnvironmentObject var userData: UserData
    @State var date: String = "none"
    @State var addingItem: Bool = false
    @State var editingItem: Bool = false
    @State var goalBeingEditedID: Int = 0
    let dayIndex = Calendar.current.component(.weekday, from: Date()) - 1
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 0){
                Text("Today's Goals")
                    .foregroundColor(Color.black)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding()
                    .padding(.leading, 10)
                    .multilineTextAlignment(.leading)
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 10){
                        
                        ForEach(userData.userGoals) {goal in
                            if  Calendar.current.isDateInToday(goal.startTime){
                                GoalBox(goal: goal)
                                .onLongPressGesture {
                                    self.goalBeingEditedID = goal.id
                                    self.editingItem.toggle()
                                }
                            }
                        }
                        ReflectButton()
                            .padding(.top, 10)
                    }
                    .padding()
                    .frame(minWidth: UIScreen.main.bounds.size.width)
                }
            }
            
            if(addingItem){
                GeometryReader{_ in
                    BlurView(style: .light)
                        .onTapGesture {
                            self.addingItem.toggle()
                    }
                    AddGoalNoBack(userData: self._userData, addingItem: self.$addingItem)
                        .padding(.top, 40)
                        .padding(.leading, -10)
                }.background(
                    Color.black.opacity(0.65)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.addingItem.toggle()
                    }
                )
                    .edgesIgnoringSafeArea(.all)
            }
            else{
                Button(action: {self.addingItem.toggle()}) {
                    AddButton()
                }
                .scaleEffect(0.2)
                .offset(x: 130, y: 270)
                //TODO: This needs to be adjusted to work with all screen sizes
            }
            
            if(editingItem){
                GeometryReader{_ in
                    BlurView(style: .light)
                        .onTapGesture {
                            self.editingItem.toggle()
                    }
                    EditGoal(userData: self._userData, goalID: self.goalBeingEditedID, editingGoal: self.$editingItem)
                        .padding(.top, 40)
                        .padding(.leading, -10)
                }.background(
                    Color.black.opacity(0.65)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.editingItem.toggle()
                    }
                )
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
