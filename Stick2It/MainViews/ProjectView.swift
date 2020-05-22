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
    @State var addingProject: Bool = false
    
    var body: some View {
        ZStack{
//            VStack(alignment: .leading, spacing: 0){
//                Text("Projects")
//                    .foregroundColor(Color.black)
//                    .font(.largeTitle)
//                    .fontWeight(.heavy)
//                    .padding()
//                    .padding(.leading, 10)
//                    .multilineTextAlignment(.leading)
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
                    AddProjectNoBack(userData: self._userData, addingItem: self.$addingProject)
                        .padding(.top, 40)
                    
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
                Button(action: {self.addingProject.toggle()}) {
                    AddButton()
                }
                .scaleEffect(0.2)
                .offset(x: 130, y: 270)
                //TODO: This needs to be adjusted to work with all screen sizes
                
                
            }
        }
        
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView()
    }
}
