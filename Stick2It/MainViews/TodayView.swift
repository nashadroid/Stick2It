//
//  TodayView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/8/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

enum overlayViews {
    case addGoal, editGoal, reflect, addRoutine, editRoutine, addProject, none
}

struct TodayView: View {
    @EnvironmentObject var userData: UserData
    @State var date: String = "none"
    @State var goalBeingEditedID: Int = 0
    @State var currentOverlay = overlayViews.none
    let dayIndex = Calendar.current.component(.weekday, from: Date()) - 1
    let generator = UIImpactFeedbackGenerator(style: .heavy)
    
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
                                    self.currentOverlay = .editGoal
                                }
                            }
                        }
                        Button(action: {
                            self.generator.impactOccurred()
                            self.currentOverlay = .reflect
                        }){
                            
                            ReflectButton()
                            
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                    .frame(minWidth: UIScreen.main.bounds.size.width)
                }
            }
            // ADD BUTTON
            Button(action: {self.currentOverlay = .addGoal}) {
                AddButton()
            }
            .scaleEffect(0.2)
            .offset(x: 130, y: 270)
            //TODO: This needs to be adjusted to work with all screen sizes
            
            overlayView()
            
//            if(addingItem){
//                GeometryReader{_ in
//                    BlurView(style: .light)
//                        .onTapGesture {
//                            self.addingItem.toggle()
//                    }
//                    AddGoalNoBack(userData: self._userData, addingItem: self.$addingItem)
//                        .padding(.top, 40)
//                        .padding(.leading, -10)
//                }.background(
//                    Color.black.opacity(0.65)
//                        .edgesIgnoringSafeArea(.all)
//                        .onTapGesture {
//                            self.addingItem.toggle()
//                    }
//                )
//                    .edgesIgnoringSafeArea(.all)
//            }
//
//            if(editingItem){
//                GeometryReader{_ in
//                    BlurView(style: .light)
//                        .onTapGesture {
//                            self.editingItem.toggle()
//                    }
//                    EditGoal(userData: self._userData, goalID: self.goalBeingEditedID, editingGoal: self.$editingItem)
//                        .padding(.top, 40)
//                        .padding(.leading, -10)
//                }.background(
//                    Color.black.opacity(0.65)
//                        .edgesIgnoringSafeArea(.all)
//                        .onTapGesture {
//                            self.editingItem.toggle()
//                    }
//                )
//                    .edgesIgnoringSafeArea(.all)
//            }
//
//            if(reflecting){
//                GeometryReader{_ in
//                    BlurView(style: .light)
//                        .onTapGesture {
//                            self.reflecting.toggle()
//                    }
//                    VStack{
//                        Spacer()
//                        ReflectionPage(reflecting: self.$reflecting)
//                            .padding(20)
//                        Spacer()
//                    }
//                }.background(
//                    Color.black.opacity(0.65)
//                        .edgesIgnoringSafeArea(.all)
//                        .onTapGesture {
//                            self.editingItem.toggle()
//                    }
//                )
//                    .edgesIgnoringSafeArea(.all)
//
//
//
//            }
        }
    }
    func overlayView() -> AnyView {
        
        switch self.currentOverlay {
        case .addGoal:
            return AnyView(GeometryReader{_ in
                BlurView(style: .light)
                    .onTapGesture {
                        self.currentOverlay = .none
                }
                AddGoalNoBack(userData: self._userData, currentOverlay: self.$currentOverlay)
                    .padding(.top, 40)
                    .padding(.leading, -10)
            }.background(
                Color.black.opacity(0.65)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.currentOverlay = .none
                }
            )
                .edgesIgnoringSafeArea(.all)
            )
            
        case .editGoal:
            return AnyView(GeometryReader{_ in
                BlurView(style: .light)
                    .onTapGesture {
                        self.currentOverlay = .none
                }
                EditGoal(userData: self._userData, goalID: self.goalBeingEditedID, currentOverlay: self.$currentOverlay)
                    .padding(.top, 40)
                    .padding(.leading, -10)
            }.background(
                Color.black.opacity(0.65)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.currentOverlay = .none
                }
            )
                .edgesIgnoringSafeArea(.all)
            )
            
        case .reflect:
            return AnyView(GeometryReader{_ in
                BlurView(style: .light)
                    .onTapGesture {
                        self.currentOverlay = .none
                }
                VStack{
                    Spacer()
                    ReflectionPage(currentOverlay: self.$currentOverlay)
                        .padding(20)
                    Spacer()
                }
            }.background(
                Color.black.opacity(0.65)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.currentOverlay = .none
                }
            )
                .edgesIgnoringSafeArea(.all)
            )
            
        default:
            return AnyView(Text(""))
            
        }
        
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
