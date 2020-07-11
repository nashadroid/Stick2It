//
//  ReflectionPage.swift
//  Stick2It
//
//  Created by Nashad Rahman on 7/10/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct ReflectionPage: View {
    @State private var name: String = "Tim"
    
    var body: some View {
        VStack{
            Text("How is today going?")
            TextField("Enter your name", text: $name)
            Text("Hello, \(name)!")
        }
        .background(Color.white.shadow(radius: 10))
    }
}

struct ReflectionPage_Previews: PreviewProvider {
    static var previews: some View {
        ReflectionPage()
    }
}
