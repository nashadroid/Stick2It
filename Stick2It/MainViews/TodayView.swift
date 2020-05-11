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
                            }
                        }
                        
                        Button(action: {self.userData.checkRoutineAddGoalsAsNeeded(date: self.date, dayNum: self.dayIndex)}) {
                            Text("Refresh")
                        }
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
                    
                    AddItemNoBack(userData: self._userData, addingItem: self.$addingItem)
                        .padding(.top, 40)
                    
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
            
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
