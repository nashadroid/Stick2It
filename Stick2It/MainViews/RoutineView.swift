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
    @State var currentOverlay = overlayViews.none
    @State var routineBeingEditedID: Int = 0
    let generator = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 0){
                Text("Routines")
                    .foregroundColor(Color.black)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.top, 10)
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.leading)
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 10){
                        
                        ForEach(userData.userRoutines) {routine in
                            RoutineBox(routine: routine)
                                .onLongPressGesture {
                                    self.routineBeingEditedID = routine.id
                                    self.currentOverlay = .editRoutine
                            }
                        }
                    }
                    .padding()
                }
            }
            
            GeometryReader { geo in
                Button(action: {self.currentOverlay = .addRoutine}) {
                    AddButton()
                }
                .scaleEffect(0.2)
                .offset(x: geo.size.width * 0.35, y: geo.size.height * 0.42)
            }
            
            overlayView()
        }
    }
    
    func overlayView() -> AnyView {
        
        switch self.currentOverlay {
        case .addRoutine:
            return AnyView(
                GeometryReader{_ in
                    BlurView(style: .light)
                        .onTapGesture {
                            self.currentOverlay = .none
                    }
                    
                    AddRoutineNoBack(userData: self._userData, currentOverlay: self.$currentOverlay)
                        .padding(.top, 40)
                }.background(
                    Color.black.opacity(0.65)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.currentOverlay = .none
                    }
                )
                    .edgesIgnoringSafeArea(.all)
            )
            
        case .editRoutine:
            return AnyView(
                GeometryReader{_ in
                    BlurView(style: .light)
                        .onTapGesture {
                            self.currentOverlay = .none
                    }
                    EditRoutine(currentOverlay: self.$currentOverlay, routineID: self.routineBeingEditedID)
                        .padding(.top, 40)
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
