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
        Color.white
            .overlay(
                
                ZStack{

                    VStack{
                        ForEach(userData.userGoals) {goal in
                            GoalBox(goal: goal)
                            .padding(5)
                        }
                        
                        Button(action: {self.addingItem.toggle()}) {
                            Text("Add")
                        }
                        
                    }
                    .padding()
                    
                    if(addingItem){
                        GeometryReader{_ in
                            BlurView(style: .light)
                                .onTapGesture {
                                        self.addingItem.toggle()
                                }
                                
                            AddItem()
                                .padding(.top, 40)
                        
                        }.background(
                            
                            Color.black.opacity(0.65)
                                .edgesIgnoringSafeArea(.all)
                                .onTapGesture {
                                        self.addingItem.toggle() //TODO Delete one of these
                                }
                        
                        )

                        
                    }
                    
                }
            
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .environmentObject(UserData())
    }
}

