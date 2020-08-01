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
    @State private var loaded = false
    
    var body: some View {
        VStack{
            
            HStack{
                Button(action: {
                    self.currentOverlay = .none
                    DispatchQueue.main.asyncAfter(deadline: .now()){
                        UserDefaults.standard.set(self.allowNotifications, forKey: "allowNotifications")
                        UserDefaults.standard.set(self.connectToCal, forKey: "connectCalendar")
                        self.userData.saveCalendars()
                        self.userData.addGoalsFromCal()
                        self.userData.refeshEnabledFromCalendars()
                        self.userData.refreshNotifications()
                    }
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
                        .onReceive([self.allowNotifications].publisher.first()) { (value) in
                            print("New value is: \(value)")
                            if self.loaded {
                                UserDefaults.standard.set(self.allowNotifications, forKey: "allowNotifications")
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                                    self.userData.refreshNotifications()
                                }
                            }
                        }
                        .padding(5)
                    }
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                    .padding(.top, 20)
                    
//                    VStack(alignment: .leading){
                        HStack(alignment: .center){
                            Text("Connect to\nCalendar")
//                                .lineLimit(nil)
//                                .truncationMode()
                                .fontWeight(.heavy)
                                
                                .lineLimit(2)
                                .fixedSize(horizontal: false, vertical: true)
                                //.minimumScaleFactor(0.999)
//                                .frame(maxWidth: .infinity)
                                .padding(.leading, 5)
                                .foregroundColor(Color.white)
                                .animation(nil)
                            
                            Toggle("", isOn: $connectToCal)
                                .onReceive([self.connectToCal].publisher.first()) { (value) in
                                    print("New value is: \(value)")
                                    if self.loaded {
                                        UserDefaults.standard.set(self.connectToCal, forKey: "connectCalendar")
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                                            self.userData.checkCalendarsAddAccordingly()
                                        }
                                    }
                                }
                            
//                            Toggle(isOn: $connectToCal){
//                                Spacer()
//                            }
//                            .onTapGesture {
//                                UserDefaults.standard.set(self.connectToCal, forKey: "connectCalendar")
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
//                                    self.userData.checkCalendarsAddAccordingly()
//                                }
//                            }
                            .padding(5)
                        }
//                    }
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
                                    .onTapGesture {
                                        self.userData.checkCalendarsAddAccordingly()
                                }
                            }
                            .frame(maxWidth: .infinity)
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
            print("Appeared")
            self.loaded = true
        }
    }
}

//
//struct SettingsMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsMenu()
//    }
//}
