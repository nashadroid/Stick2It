//
//  RoutineView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/8/20.
//  Copyright © 2020 NashApps. All rights reserved.
//
//  Shows routines

import SwiftUI

struct RoutineView: View {
    @EnvironmentObject var userData: UserData
    @State var currentOverlay = overlayViews.none
    @State var routineBeingEditedID: Int = 0
    let generator = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 0){
                
                // Title
                Text("Routines")
                    .foregroundColor(Color.black)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.top, 10)
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.leading)
                
                // Show Routines
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
            
            // Add Buttone
            GeometryReader { geo in
                Button(action: {self.currentOverlay = .addRoutine}) {
                    AddButton()
                }
                .scaleEffect(0.2)
                .offset(x: geo.size.width * 0.35, y: geo.size.height * 0.42)
            }
            
            // Call on overlay
            overlayView()
        }
    }
    
    func overlayView() -> AnyView {
        
        switch self.currentOverlay {
            
        // Add Routine overlay
        case .addRoutine:
            return AnyView(
                ZStack{
                    BlurView()
                        .edgesIgnoringSafeArea(.all)
                    
                    AddRoutineNoBack(userData: self._userData, currentOverlay: self.$currentOverlay)
                        .background(
                            Color.black.opacity(0.4)
                                .edgesIgnoringSafeArea(.all)
                                .onTapGesture {
                                    self.currentOverlay = .none
                            }
                            
                    )
                }
            )
            
        // Edit Routine Overlay
        case .editRoutine:
            return AnyView(
                ZStack{
                    BlurView()
                        .edgesIgnoringSafeArea(.all)
                    
                    EditRoutine(currentOverlay: self.$currentOverlay, routineID: self.routineBeingEditedID)
                        .padding(.top, 40)
                        .background(
                            Color.black.opacity(0.4)
                                .edgesIgnoringSafeArea(.all)
                                .onTapGesture {
                                    self.currentOverlay = .none
                            }
                            
                    )
                }
            )
            
        default:
            return AnyView(Text(""))
            
        }
        
    }
    
}
