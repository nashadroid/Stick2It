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
    var RoutineName: String
    var startTime: String
    var endTime: String
    var repeatOn: [String] = ["all"]
    var project: String = "none"
    var done: Bool
}
