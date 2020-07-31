//
//  SettingsMenu.swift
//  Stick2It
//
//  Created by Nashad Rahman on 7/29/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct SettingsMenu: View {
    @EnvironmentObject var userData: UserData
    @Binding var currentOverlay: overlayViews
    @State private var allowNotifications: Bool = false
    @State private var connectToCal: Bool = false
    
    var body: some View {
        VStack{
            
            HStack{
                Button(action: {
                    self.currentOverlay = .none
                    UserDefaults.standard.set(self.allowNotifications, forKey: "allowNotifications")
                    UserDefaults.standard.set(self.connectToCal, forKey: "connectCalendar")
                    self.userData.saveCalendars()
                    self.userData.addGoalsFromCal()
                    self.userData.refeshEnabledFromCalendars()
                    self.userData.refreshNotifications()
                }) {
                    Text("Back")
                        .foregroundColor(Color.white)
                        .padding(.top, 15)
                        .padding(.bottom, 15)
                }
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            
            
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
            
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    
                    
                    HStack(alignment: .center){
                        Text("Allow Notifications")
                            .fontWeight(.heavy)
                            .padding(.leading, 5)
                            .foregroundColor(Color.white)
                        Toggle(isOn: $allowNotifications){
                            Spacer()
                        }
                        .padding(5)
                    }
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading){
                        HStack(alignment: .center){
                            Text("Connect to Calendar")
                                .fontWeight(.heavy)
                                .padding(.leading, 5)
                                .foregroundColor(Color.white)
                                .lineLimit(2)
                            Toggle(isOn: $connectToCal){
                                Spacer()
                            }
                            .padding(5)
                        }
                    }
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                    .padding(.top, 20)
                    
                    if self.connectToCal {
                        VStack(alignment: .leading){
                            HStack(alignment: .center){
                                Text("Select Calendars:")
                                    .fontWeight(.heavy)
                                    .padding(10)
                                    .foregroundColor(Color.white)
                            }
                            ForEach(self.userData.userCalendars){cal in
                                Button(action: {
                                    self.userData.userCalendars[
                                        self.userData.userCalendars.firstIndex(where: {cal.calendarName == $0.calendarName}) ?? 0].enabled.toggle() }){
                                                HStack{
                                                    Text(cal.calendarName)
                                                        .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: cal.enabled ? 1 : 0.6))
                                                        .font(.footnote)
                                                        .fontWeight(.heavy)
                                                        
                                                    Spacer()
                                                }
                                                .padding(10)
                                                .padding(.leading, 10)
                                                .frame(maxWidth: .infinity)
                                                .background(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: cal.enabled ? 0.3 : 0))
                                }
                                
                            }
                        }
                        .onAppear(){
                            self.userData.checkCalendarsAddAccordingly()
                        }
                        .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                        .padding(.top, 20)
                    }
                }
                .padding(5)
                .padding(.bottom,250)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            }
        }
        .onAppear {
            self.allowNotifications = UserDefaults.standard.object(forKey: "allowNotifications") as? Bool ?? false
            self.connectToCal = UserDefaults.standard.object(forKey: "connectCalendar") as? Bool ?? false
        }
    }
}

//
//struct SettingsMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsMenu()
//    }
//}
