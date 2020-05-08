//
//  ContentView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/4/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

enum CurrentView {
    case TodayView
    case RoutineView
}

struct ContentView: View {
    
    @EnvironmentObject var userData: UserData
    @State var addingItem = false
    @State var date: String = "none"
    @State var currentView = CurrentView.TodayView
    
    var body: some View {
        
        ZStack{
            
            //This is the background to prevent dark mode from affecting visuals.
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
            
            if(currentView == CurrentView.TodayView){
                TodayView(userData: _userData, date: date)
            }
            
            
            
            //The add item view can appear over any other view
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
            else{
                Button(action: {self.addingItem.toggle()}) {
                    AddButton()
                }
                .scaleEffect(0.2)
                .offset(x: 120, y: 320)
                //TODO: This needs to be adjusted to work with all screen sizes
                
                
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

