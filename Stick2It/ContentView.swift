//
//  ContentView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/4/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    @State var addingItem = false
    
    var body: some View {
                
        ZStack{
            
            GeometryReader{_ in
                BlurView(style: .light)
                    .onTapGesture {
                            self.addingItem.toggle()
                    }
            }.background(
                Color.white.opacity(1.0)
                    .edgesIgnoringSafeArea(.all)
            )
            .edgesIgnoringSafeArea(.all)
            
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
                            GoalBox(goal: goal)
                        }
                        
                        Button(action: {self.addingItem.toggle()}) {
                            Text("Add")
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
                        
                    AddItemNoBack(userData: self._userData, addingItem: self.addingItem)
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .environmentObject(UserData())
    }
}

