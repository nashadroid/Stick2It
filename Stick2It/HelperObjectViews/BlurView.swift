//
//  Blur View.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/5/20.
//  Copyright © 2020 NashApps. All rights reserved.
//  From Stack Overflow https://stackoverflow.com/questions/56610957/is-there-a-method-to-blur-a-background-in-swiftui/56611342
//

import SwiftUI
import UIKit

struct BlurView: UIViewRepresentable {
    var effect: UIVisualEffect? = UIBlurEffect(style: .light)
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
