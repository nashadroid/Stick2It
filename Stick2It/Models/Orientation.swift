//
//  Orientation.swift
//  Stick2It
//
//  Created by Nashad Rahman on 6/2/20.
//  From https://forums.developer.apple.com/thread/126878
//
//

import SwiftUI

final class OrientationInfo: ObservableObject {
    enum Orientation {
        case portrait
        case landscape
    }
      
    @Published var orientation: Orientation
      
    private var _observer: NSObjectProtocol?
      
    init() {
        // fairly arbitrary starting value for 'flat' orientations
        if UIDevice.current.orientation.isLandscape {
            self.orientation = .landscape
        }
        else {
            self.orientation = .portrait
        }
          
        // unowned self because we unregister before self becomes invalid
        _observer = NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: nil) { [unowned self] note in
            guard let device = note.object as? UIDevice else {
                return
            }
            if device.orientation.isPortrait {
                self.orientation = .portrait
            }
            else if device.orientation.isLandscape {
                self.orientation = .landscape
            }
        }
    }
      
    deinit {
        if let observer = _observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
