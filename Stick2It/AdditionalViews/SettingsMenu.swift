//
//  SettingsMenu.swift
//  Stick2It
//
//  Created by Nashad Rahman on 7/29/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import EventKit
import SwiftUI

struct SettingsMenu: View {
    @EnvironmentObject var userData: UserData
    @Binding var currentOverlay: overlayViews
    @State private var allowNotifications: Bool = false
    @State private var connectToCal: Bool = false
    @State private var loaded = false
    @State private var notificationTime = 0
    @State private var updater: Bool = true
    
    var body: some View {
        VStack{
            
            HStack{
                Button(action: {
                    self.currentOverlay = .none
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.001){
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
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                }
                Spacer()
            }
            
            
            
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
                        Toggle(isOn: $allowNotifications.animation()){
                            Spacer()
                        }
                        .onReceive([self.allowNotifications].publisher.first()) { (value) in
                            if self.loaded {
                                if self.allowNotifications{
//                                    let store = EKEventStore()
//                                    store.requestAccess(to: .event, completion: {success, error in
//                                        if success {
//                                            self.updater.toggle()
//                                            self.userData.refreshNotifications()
//
//                                        }
//
//                                    })
                                }
                                
                                UserDefaults.standard.set(self.allowNotifications, forKey: "allowNotifications")
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                                    self.userData.refreshNotifications()
//                                }
                            }
                        }
                        .padding(5)
                    }
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                    .padding(.top, 20)
                    
                    if allowNotifications {
                        
                            VStack(alignment: .center){
                                Text("Notify me \(notificationTime) min before")
                                    .fontWeight(.heavy)
                                    .padding(.leading, 5)
                                    .foregroundColor(Color.white)
                                Picker(selection: $notificationTime, label: Text("Please choose a time")) {
                                    ForEach((0 ..< 121)) {
                                        Text(String($0))
                                    }
                                }
                                .frame(maxWidth: 100, maxHeight: 200)
                                
                                
                                //.padding(5)
                            }
                            .padding(5)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                            .padding(.top, 20)
                        
                        if !self.userData.notificationsAllowed() {
                            Text("It looks like you haven't allowed Koalati to send you notifications. Go to Settings > Notifications to toggle.")
                                .fontWeight(.light)
                                .italic()
                                .font(.footnote)
                                .padding(.leading, 5)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    
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
                            //.animation(nil)
                        
                        Toggle("", isOn: $connectToCal.animation())
                            .onReceive([self.connectToCal].publisher.first()) { (value) in
                                if self.loaded {
                                    UserDefaults.standard.set(self.connectToCal, forKey: "connectCalendar")
                                    
                                    if self.connectToCal {
                                        let store = EKEventStore()
                                        store.requestAccess(to: .event, completion: {success, error in
                                            if success {
                                                self.updater.toggle()
                                                self.userData.checkCalendarsAddAccordingly()
                                                self.updater.toggle()
                                            }
                                            
                                        })
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                                        self.userData.checkCalendarsAddAccordingly()
                                    }
                                }
                        }
                        .padding(5)
                    }
                        //                    }
                        .padding(5)
                        .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                        .padding(.top, 20)
                    
                    if self.connectToCal {
                        if self.userData.getListOfCal().count == 0
                        {
                            Text("It looks like you haven't allowed Koalati to access your calendars. Go to Settings > Privacy > Calendar to toggle.")
                                .fontWeight(.light)
                                .italic()
                                .font(.footnote)
                                .padding(.leading, 5)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity)
                        }
                        if self.userData.getListOfCal().count > 0 {
                            VStack(alignment: .leading){
                                HStack(alignment: .center){
                                    Text("Tap to Select Calendars:")
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
            _ = self.userData.notificationsAllowed()
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
