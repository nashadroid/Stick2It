//
//  SwiftUIView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/8/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct Routine: Hashable, Codable, Identifiable {
    
    var id: Int
    var routineName: String
    var startTime: String
    var endTime: String
    var repeatOn: [Int] = []
    var running: Bool = true
    var project: String = "none"
    
}
