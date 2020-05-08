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
    
    var body: some View {
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
                        if self.date == goal.date{
                            GoalBox(goal: goal)
                        }
                    }
//
//                        Button(action: {self.addingItem.toggle()}) {
//                            Text("Add")
//                        }
                }
                .padding()
                .frame(minWidth: UIScreen.main.bounds.size.width)
            }
                        
                    }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
