//
//  ProjectView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/11/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct ProjectView: View {
    @EnvironmentObject var userData: UserData
    @State var currentOverlay = overlayViews.none
    @State var addingProject: Bool = false
    
    var body: some View {
        ZStack{
            NavigationView {
                List(userData.userProjects) {project in
                    NavigationLink(destination: ProjectDetailedView(project: project)){
                        Text(project.projectName)
                    }
                }
                .navigationBarTitle(Text("Projects"))
            }
            
            if(addingProject){
                GeometryReader{_ in
                    BlurView(style: .light)
                        .onTapGesture {
                            self.addingProject.toggle()
                    }
                    AddProjectNoBack(userData: self._userData, currentOverlay: self.$currentOverlay)
                        .padding(.top, 40)
                        .padding(.leading, -10)
                    
                }.background(
                    Color.black.opacity(0.65)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.addingProject.toggle()
                    }
                )
                    .edgesIgnoringSafeArea(.all)
            }
            else{
                GeometryReader { geo in
                    Button(action: {self.currentOverlay = .addGoal}) {
                        AddButton()
                    }
                    .scaleEffect(0.2)
                    .offset(x: geo.size.width * 0.35, y: geo.size.height * 0.42)
                }
                
            }
        }
        
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView()
    }
}
